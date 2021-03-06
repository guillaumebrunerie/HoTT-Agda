{-# OPTIONS --without-K #-}

open import Base

open import Homotopy.PushoutDef

module Homotopy.PushoutIsPushout {i} (d : pushout-diag i) where

import Homotopy.PushoutUP as PushoutUP
open PushoutUP d (λ _ → unit) -- A B C f g (λ _ → unit)

pushout-cocone : cocone (pushout d)
pushout-cocone = (left , right , glue)

factor-pushout : (E : Set i) → (cocone E → (pushout d → E))
factor-pushout E (A→top , B→top , h) = pushout-rec-nondep E A→top B→top h

abstract
  pushout-is-pushout : is-pushout (pushout d) pushout-cocone
  pushout-is-pushout E ⦃ tt ⦄ = iso-is-eq _ (factor-pushout E)
    (λ y → map (λ u → _ , _ , u)
               (funext (λ x → pushout-β-glue-nondep E (cocone.A→top y)
                                    (cocone.B→top y) (cocone.h y) x)))
    (λ f → funext (pushout-rec _ (λ _ → refl _) (λ _ → refl _)
      (λ c → trans-app≡app
             (pushout-rec-nondep E (f ◯ left) (f ◯ right)
              (λ c' → map f (glue c')))
             f (glue c) (refl _)
             ∘ (map (λ u → ! u ∘ map f (glue c))
                  (pushout-β-glue-nondep E (f ◯ left) (f ◯ right)
                   (λ c' → map f (glue c')) c)
                  ∘ opposite-left-inverse (map f (glue c))))))
