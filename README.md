# Passive Dynamic Walking (PDW) Robot

[MATLAB] PDW Robot Simulation Code



## Implemented models

### Compass gait model

#### Symmetric model

- Point foot model ([Compass-like biped robot - Goswami et al.](https://hal.inria.fr/inria-00073701/file/RR-2996.pdf))
- Arc shape foot model ([T McGeer](https://users.dimi.uniud.it/~antonio.dangelo/Robotica/2019/helper/leggedRobot/McGeer-Passive_dynamic_walking.pdf))
- Flat shape foot model ([MW Spong et al.](https://ieeexplore.ieee.org/iel5/4376306/4376307/04376312.pdf?casa_token=voxBKxih_IUAAAAA:WugTLWGqKSPHyVzvV0aAtvCpZ0DTGv8CwP5Vo3XLf8V9-VeZr3CtWCd7DDbIv6UpG9iTsULEC2A))
- Upper body model ([M Wisse et al.](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/5B6847FB3E431F3F5A206436F1D74362/S0263574704000475a.pdf/div-class-title-passive-dynamic-walking-model-with-upper-body-div.pdf?casa_token=lkx8IjEi2QwAAAAA:ANd7dZRZLYYH8ivSfQsX1gXaUrTwZUosHCXAJapLbcEpKrTfWsGv-FFxieYmPqdwfxJWv9mTbC12uR7V))

#### Asymmetric model

- Leg length asymmetric model (**Will release** (Paper writing))
- Leg mass asymmetric model (**Will release** (Paper writing))

---

### Knee model

- Symmetric model ([H Chen](https://dspace.mit.edu/bitstream/handle/1721.1/41635/216930106-MIT.pdf?sequence=2&isAllowed=y))
- Asymmetric model (**Will release** (Paper writing))
  - Leg length asymmetric model
  - Leg mass asymmetric model

---

### Reference

1. McGeer, Tad. "Passive dynamic walking." *Int. J. Robotics Res.* 9.2 (1990): 62-82. [[PDF](https://users.dimi.uniud.it/~antonio.dangelo/Robotica/2019/helper/leggedRobot/McGeer-Passive_dynamic_walking.pdf)]
2. Wisse, Martijn, Arend L. Schwab, and Frans CT van der Helm. "Passive dynamic walking model with upper body." *Robotica* 22.6 (2004): 681-688. [[PDF](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/5B6847FB3E431F3F5A206436F1D74362/S0263574704000475a.pdf/div-class-title-passive-dynamic-walking-model-with-upper-body-div.pdf?casa_token=_iZGLAq1fogAAAAA:i9ifENC2cG0LK_NB46oDTsdrTq8Z1h1wmq3zUJOFWLXxRthumU5-XwvmtyeaODc6-5o2fjjhrAX7G-0Q)]
3. Chen, Hsu. *Passive dynamic walking with knees: A point foot model*. Diss. Massachusetts Institute of Technology, 2007. [[PDF](https://dspace.mit.edu/bitstream/handle/1721.1/41635/216930106-MIT.pdf?sequence=2&isAllowed=y)]
4. Kim, Joohyung, Chong-Ho Choi, and Mark W. Spong. "Passive dynamic walking with symmetric fixed flat feet." *2007 IEEE International Conference on Control and Automation*. IEEE, 2007. [[PDF]()]
5. Goswami, Ambarish, Benoit Thuilot, and Bernard Espiau. *Compass-like biped robot part I: Stability and bifurcation of passive gaits*. Diss. INRIA, 1996. [[PDF](https://hal.inria.fr/inria-00073701/file/RR-2996.pdf)]
6. Kim, Joohyung, Chong-Ho Choi, and Mark W. Spong. "Passive dynamic walking with symmetric fixed flat feet." *2007 IEEE International Conference on Control and Automation*. IEEE, 2007. [[PDF](https://ieeexplore.ieee.org/iel5/4376306/4376307/04376312.pdf?casa_token=J1Sm9BYNauYAAAAA:KpoNSuZ4zfM3IT4Elu7sBHXTvrKVQkBMtnzrJMiU8_YjAS1XLj6euCehZpWokXcAIOyScW-99HM)]
