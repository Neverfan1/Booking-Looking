//
//  AccommodationModel.swift
//  Booking Looking
//
//  Created by Данила Парамин on 23.04.2023.
//

import Foundation

struct AccommodationBookingModel:Identifiable{
    
    let id: Int
    let booking_id: Int
    let type:String
    let owner_id:Int
    let owner_name:String
    let image_preview:String
    let images:[String]
    let price:Int
    let booking_dates: [DateResponse]
    let address: String
    
}

struct AccommodationSearchModel: Identifiable{
    
    let id: Int
    let type:String
    let owner_id:Int
    let owner_name:String
    let image_preview:String
    let address:String
    let price:Int
}

struct AccommodationDetailModel: Identifiable{
    
    let id: Int
    let address:String
    let description:String
    let image_preview:String
    let images: [String]
    let type:String
    let rooms:Int
    let beds:Int
    let capacity:Int
    let owner_id:Int
    let owner_name:String
    let price:Int
    let cancellation_policy:String
    let free_dates: [DateResponse]
    
}



struct DateResponse: Identifiable, Hashable {
    let id = UUID()
    let month: Int
    let year: Int
    let dates: [Int]
}




extension AccommodationDetailModel{
    static func mock() -> Self {
        AccommodationDetailModel(id: 1,
                           address: "г. Саратов, ул. Пушника, д. 17в",
                           description: "Test Test Test Test Test Test Test Test Test TEst Test TEst Test ETst",
                           image_preview: "https://remont-f.ru/upload/iblock/597/dizayn-interyera-kvartiry-v-sovremennom-stile-gostinaja-2.jpg",
                           images: [
                            "https://lh3.googleusercontent.com/SGtlM_cx537U7CjjNlRdFmlnCdgcpwlvgNN17xm0kbKuCBUNGkGw8Zn632kQGpxtsw56NLzQhdXjpMeiATQWEIxkFEDr-_SjP__ytvVg-bbE7PfBSQj2xrZT4JZDKLyKXgMGgrAMvDhd0sF12yd8feSuCdJVoGfebQNITpbhAg4y_thGhYuioRePJWW2lvf3x3aZ2wD4r_bnghnhyRjj71vuJMZTXKKssUdbLNi6oLr_v3GLf78hEBScxzOPn3yBvv2lsmvouht1SmZKnVg31W7mkrQFBm-5gkT6zXARs2Ey3zfn05HLDuX1zCEePzAe7Fw-xqZthXfz9NNbDfKNztAZ3g4a5VARKfp_92uUsoEd8msTsAUNZMbgesIx_NTucp534SPKlzZ2GUQUJOZBGbmsR61l7TyFsN8YL3tDGa-CtuWOYDQTFrJDfASWg120tcr1fPWF0QbggfP_RZySL__JQdO5ZEnCuVCIcES8OszVHaOFhwJU_k1YxyL0o1xWmyM72s6WUFBPIExkuqdIJlc9-r_WLjWIvWUbilFQhNyOt2uovpFYCbM7ORZ70rLrIJPbUzFHPuu6qHLN594e6t5SMHh5udHe6ZkPk0GZXT2GvrD4apsCKaVziQNrRymp41GMwc3eL_pih5QG3wqwCiL4vPVCApMsnR7Wb1ZAuQjsgYCK5W4syl06sTjV3rIAlV1R4w7LwUidBkmIjVU0706znD3S5O2frWK4A915AtYZmXM9Nmj3d4YoyKOGz2a2wO1bp1FqIXe5z-lQfsPXSYG4KgffMQoVYOX5qjLsW9_0hW5gkJ_5IOZ38iLRhyK_LUlbMSw-sjqsG1PVBDBUrcCtTzesejBqIOrmayzFMP-b35X0ui_VHbUEBxbD36C5-wq7caUK9ww6hu4xf7Swq6v7kCXZN6iHGd9qFMyCwB86eHwM1MPGQzJNoj3u3FhAg8lcelwNIf5-UyX3WTI=w1067-h800-s-no?authuser=1",
                            "https://lh3.googleusercontent.com/cESEOUFjs_ODY3PUR1Qxt1wxxA31ze410y4E13-IQzREPbVnGNdZtZyROLOcw9aeGraWYMQZXjPYDf7HYxR3yJtwtwus86-LyeMM5xJQyiOgA7zD-WedVGPvx4YLGMGRDZjTFcZlGXKCcZ0_BrFpwHndSni2mHJ7YLuIM-Qm04XUoUCRE9eSnpKFCAecadHpCsK_oBLfh89Q_Ig5OxD3WGNnfOMSU3bE-y_p3r9cQjYiugchbNm3ubjt-Sjy-jKg_MPsWJOtC9tQqb51kWpYQduP3NGMykfXJbQFHxEpImBacMkmzQGFuC_aHE3Yw6MTWYO9Fy2Fp78dEOAyiwb2WfkBRPUREmMDPbZljg6e2e1yJVQT_GnJyMS5da9XHNJ17nkw4TNeV0iHxeamfdLgohcRjOWGx16D0G8wfdkcYDZ_ANP5GbqWqs2WpFDJCAJjyDovFjgQfdIFdoYhoEwgzrEwgYRM1B-HZ1YvGkdONXGSfAJwsu8X3cPjoIxD0Pks1Yt0vqHyM-z5I_j5_s4BZHTFiRILrHntymehlvzsLwwb-YlnB-HoXh0vJLzA6BMFXLsvViZW4CLRfuA6O4z-wKd6g8MZOz4ZvEc7knE00pcS5ewc4rtyeMP3tWi0HRAnxcGBpCeF7uD0OveGIH6RmE1wx7VcRPBFMz_jmzI03jPrysUTbVoPmVigL_r63_x7L_2r-BLBEBd7t4aSNeRrZ3gH2CWoDMYOyrIhJiFnIAkGnhaGTyvElKXFQfM0vVPVbGQ7CQCgrwhH4IYprHavcAR8d1etnUHhSCEHo32KXqHpV_ootaEi-jA9e60WfKrE75gEQCkCTsiAJ3emfbAKKP2_lPaG2J2Avmbpz8JoG_OtalNwxNIR6csOdcpuQ8MhpR_TaZmPOWy0qTJsc8h51nhztBBuv4XOzvbIJBc6hXOV11uVQW03VKGiiwdAYFHRMjGxWYJEC2wyUYsJjX4=w1067-h800-s-no?authuser=1",
                            "https://lh3.googleusercontent.com/ADZiBh8RT2cSuZ8n3wtym0pCbdYoOVRM0f6wiQpXpKU_v10PmxIo9F4ZbDD5b54QCRXuzqsclgnPExLVCmg9_FCR07JubAdiLgIURtEhdeGRji-OhtMDuMBPZ45rA5Av-VPhBUCYogyUTUR6cu9AH7AsITFaoITgn3P1FgF-uIE3PVeH1uE8dnN4mW4kCuiqGIm1gj4svvKZzE4dawbfLM8I-DgLiAjvqCmxy-ls-BVlbYZ9yZCGPk4F8xOs0O_Qypa5tqgUhZbZIius5mJ_p9XymFqqDgEfxiKqgkv_yt8ROw4rjY8NeJ051xw-eqTZxg_XmpWQXUkVUEBo_XOph1l8K3gKjuavgfREk60KvDyk8BmUv4Psp_MwiToc7fNS9FOMARpcv9kPFfjCLYXvLca0-lVzVnJwwnMFw3lMOD6-Ac4gH9pybXy06C_7nyqUBumTDevfiItrif-FlXrvy95xfSdSwp-dJ9vxlRee-WmmpXt93niVLu3WPwMV9k2KmCKHVUqtsJJw9BTd-tMdRi05MRXBo2DwSBbvben5aMm_8h0t_tERAKPkgWFTqWTK6F--URHx03MqhrXwFNUARecZeMjyncSGNv3s15PO5m3bgmWmkNSOh3GZXWpftp14DqzMPCDgSX6XtHbXALx6RFebe4XhGtWgLLMXwtzXHyNBh7pYtDJQAqCD9zF_EV9mvfolFZV5wRKJrCEBrbKmdOYxp3582VMzmRmEk8kunCfbngycpYrEUdHijV7Sf3ucZnTe9gptVGXz2E_ekn5eU3sJu15mhtHAGTBDShYXUopJohi05MlvY7hjPQ7wpc82pJozonkYmmuzweT-XyZGIg36JyvSEFA1iCVf67B0I3NQuTdCRXKm5I61JRBO0zGE8SlP6JQuk5QKcFFsVPuadfaKuZobkfPTm_B2ivAeNAomJ6GSP3EYyUBz3ta84MW9B6SwRscDAdcGgMqDCSs=w1067-h800-s-no?authuser=1",
                            "https://lh3.googleusercontent.com/zNhunWl4EseYAnYuMxRAAm-DXn6COhROdpBamYTNO9Uzzea0FuryYFEWFbuSCygBbpFO54H36PgFVwGieYSqoaTXXircpnW5GyBTVNmLJGke6CWxcqymZjcayp9I-ZiqEF7BZLKOUK8XglAI0hPbXBJboGFvRglx1vqWI5uGSJxXcRz7eFMGzyVfv81qL5VRKIjNtvoqdPTGiXYPJsHUdO2ZBi6pAZOiV2s3H2o7qlzInN3Hgwg5num0zoD_QCZeATOseyncBt9bHJUuV6lELKPxHic80D_N2J10w3mL1YmfX16URZULvoQBCZ309ISr1Re_PhEfv5FrB9coxB7EfZFZkCWCwWw-I6QTC-_eIZ_eHSLpN6_1_TRt34c0oURlGxZR4ue33cIpF7AG03jXZ2JOoP0m6bzXEFiYJIyEvwsyketQmCqkMKW_8bqQq9dwtf0-wOvq1tG3YCnayEOWH-C5MyNlqDl28Xo7GnEsVoaeolAE2VnlIjw8FEDTUD4MP07jc76gcf6jsfbLSlA9Eruu8FjSYq3tPhT0EhUCAokUvcwnR8IP2EXgQRma6miO4Z675EGI4icRycumOtYyKqb9Ws11NsaKAGbGlJ2LYAFCelVkIB-eVz2oIHI_6Jg6zJQpslJ-psw3qw5Yktd_oW5PwRB0_vJbrjn8WYHBRV6tmSMtmLiS9VWm_2OrLgHW4mBGaA1PrQVKb_B-cl0Srjkhbmxwirj2BOcH8Bm4uAJNczn16dYmqAoC4q3pz0E-IbKas6Xf5eex5n8TBOPdNYRJTWtOGe7pp9WW9oSf6VJlN7L2Z83WFdkF6H3QCwHTq7j-24G1MGdIFQutOOoaCxWHy4mUV40mF9AgIOh9s91vxpodBoVUaZzq-FHOcuj4-8ZxbX1DnDokG5JYkaJdjA-91i8H1xIetQXOwFGBhcyV1wapg6KyyZIo9a3TucrHV0X3YNizgKKMfFjCcu4=w1067-h800-s-no?authuser=1",
                            "https://lh3.googleusercontent.com/lYfTZ08PwEwSgM2TbVUWaMYqpHyui53nfTeuDT5lTNRMFJfDcC4yMmyahDn1UAcdOenN8-sJi5M6GSGGGi-fs3xyf-T6CnaSBwg7ct2xJ3FOLDUAlaU0XZGxo55zHIsXChsM4qMCggbmbZ6xTGday3vk7FIUa4RZG8Pb7ShsjMymz4Xhn37Q8fyYWYBGTDyXfgEC3MEBqtwItaQDUw483a7lq9Ztlf4HnkJJhd6k93RF2AxNamk_VBSt6GRkL1ZQ6qfOPEyVXs7p_POxTyyydXdsMwpauet1UymKG3tXJtiNHfkpZiUBReEPJsvjZmf0cnDrGIf3myBB8_9-U_GiSTkhyqyJ1csUjmUc7wRTcEooEqfofSzwaoPZJ-IAyG3z70JwMuRYbDpXH-Smx7ROGSOKY-zRGTjWEWnxthuRtqUiEHhFDLl7-khh9FSt3mfQREgiBvyZM-3C0fpvSQTu9ugpo_ChCtxrQq4FvY_uK3GkCJ-BDR68f_iaH5vpfjKOJ5nx48dJ3BdjMO1obAbzpGXWd8iCUhaI_5Ajx9KJ-6_2dQsF2b1uenyuP0Za8x4iYDDrwo-yqvBW0tknninNuvM8LiGR1-RCJb4DYiK0-a987hRSt1FTsEXEYZj2QSBVpiZDQFw_GE9I-1UJYhgd8PySibSdJS8ThkQz4AQRPXXP7cTaH-Lyr3kYDTmqYQGYF4WJahf-iBdMM-NYY4NFRUyyXhFc2_bdLSSkT3rG_uL0rnXwGfCrTnMTYn2UsuVBHABc8Tikmi4k2km8mVl44PwZhgVRNW6CDFk2k5_C0B7tUdADkWUzhv7BVa_gjQSwBBXJXeFZTzdir5fzyxAtM3tlaqrv7mWLWyjpKTFFWY_bel7cuOxOSzv0f0j7dZ1QC1qSJSFkPK5kLH0NhTVFDl5CP_EvPU6NA-5stBRHzqmK62ZQvbFaXp7pSS4SBlPrDH6mgptyF7-KY-p8trY=w600-h800-s-no?authuser=1",
                            "https://lh3.googleusercontent.com/n5RlZIvVOJZfrfj0VBaRroPSWQrd9-g-5wNhedZtaeRq9_p_anIh9LiQaI_7q8i_1XGLZM6Pc3tbpVx5AYxJ7UrKBxw3yZ0r0anKIgnKpKRi06MJ0qpLqSlTo8QgNryWKGfVl8JUg8KyAfhWj8OfCBnDgqJrvnuaxAYI3SkpjZYJ4aChizywVy2HLKW9D9dtD2u5H8QOGgBmz1WRH5dH6apNa71EJaJJkvBSJrQircnbbBC1ZqUORhzmsv1ZcgzGyAqUXSsiryXotJiB568c5RIY7MN5CVYfRqhv_2FU220c618phh6-eU8oB6xzeiSM0ASiZyGTUv8tFpxGmkQI4u9AEl1uf9I88VrasQIjb8N5pHX_lueNtbPe-gy_sCOrNviflCFGCu092pmPWM2__gtl2Tj0TSf-LsGWCLaCf1Etk7RlqSeg9K954lN5mv2qHNZqD0Y6OcFb9rAhn-ZVxZ7Qu7as0rAAQzOY7q8FPn7swNe3SL_ujZ5gbUgaXQS-aBlgRwXe5FDtdKKCSAzOjb-OaU2JTwibefGLNKQFyvxYjPYVZO3hwmenbLI4-EGdOMtPAfCyh_iIgaA9ZTzzNrts797eJODhvJCav-HQazEea7Os8B-nKSjGXqhfzGiMhyoiHjPIYWWlVZcgNUhCyMCww4xbgR_c7iTzc5K9o9T4C4GchgIkGJyhG9FEUPF4WKl9cZh7LsY6jUXAPJWSkgukdX2dR3mnV19uFalmYiLTbVHJu9EATMjUgMij459G5HQ7chZrTaNzya-a3qzhNl-7IZKn2Aiba8-VGN0SyBZ98GqyP3l1u0yqq9zesCs21Wy12G5Rd4foRsSjActzP5cDZff4r20SJEVewznaRGqXpb8cw3DMAWx8PHjl7-0zF6_ZXEZ8uNNWMFjlYWu_RTVnMN7zeDX16su0WG_WZn9lO0muAwmVbt8HdNUSpuUEiTxogr8k-XBPVHvya-Y=w600-h800-s-no?authuser=1",
                            "https://lh3.googleusercontent.com/ldKxs5RpL--BKzK94u1Na40eRHt0ap-baOUJ8inluLH8zZzNnPfy4GBelSx2ErLU9UxNO1FgJfrxOijgE3v3hpPTJXjfV0gBM9H-F-IkNQndZNSciPav99fyQm-HrzecJCl_zM8QZtza5g8j6aN8MUP0WBZVB1ukDlZvX2g8nGbC3RzIG8gdjMLL7tKUs84lmUyaXBgAMj_so7k_EPNMUzr3hmQByYCEaMSJ1J3POCMugsWiaw5FvhrFAyOFc1vyslGc_gptJOx5gNQIbrOZBBFKjii3WegjYQG148-x6t0BAtTP4Ooj7GAXIcvxFjZ9m42IUrNZLXLxwQfAdojSzGojBUak62KGKkl05O7KjWaeRUp1yhezYfg_bZMlqhXA7G9_-4mYJGC2zRfr_Y33KbVreLZnQJtA4tv4jUVCtURkEqw5Iwqp20GJJbNnMr5rXg1IcfZrddUDlwkjM1AqAz2qyipu688xlbHDFai-DTWx-gncGddg_yTG36NOmRjd11YusIlcqda6c2JUcobdguZqfnLKfxuv9SwPIv3prPDfy-CdRqmFLP5wop2JPMEfz45GrPmPMp5xVvEc3zN4EhkzwYvvz1efza38tAhNwKdMqHN3s0pngq4gPCD07FQWpu52g9-3OAPHD2Phf-yAMfoOQ29TKSfU7cDwrEB94qp8fxiYV1yR1Chf0HE7HRAb6k_GUNyx-27INP_JKyzVr2PlnPY7QmQ4rCP6Wv6zGBvZfb2GxWsArDEQH9m6D51-lez_BrIm4ermt3pgaNxh3vp3xPkccRTKNDzgjg1Ti5vBRCfHWQVqHC37FnHHq-UlC26PIYCrSoMMUsLaLIqzpch0FDd9CitGW41u08jYfh3RxRuGd-FTO4_BEU7Ibg-JkLIb_68WT-hTttBiJVSjoKi74yPl0X1V-DYMNuMK3dGa0iqsRTfeRyhb7DmHR9mi8q441pQbpRpnSt7K26Q=w600-h800-s-no?authuser=1",
                            "https://lh3.googleusercontent.com/tnETafuAgw5LxfGyAMWehIRSFDdz3FLumzyAq8fuRbO5O0zhV-sEoXijNymoCCYH-CEwj0G3QwdekBHhpTtOKDGmlMJsusj3po53iWP4MmHlMuUU-xvGN3bB7ll1u9nnPIPIWNhEZxjL0y4-rEMbiKCdpUgiFZTtOctVTKt4EGRHcMe-Kuv2Awg4_cPy8O1G21IcZMoMWiOzFKcjv-GE0x7GeB1gII1H9-8OTWB4Hxu-NZ0WOjgviJ8LMi4zY6niUFc4B5OTWTs_OLjrrdJsjHHPYEmxKbnVrhK4vt05P0hbzlrjJ-8VN9mbYHMpro5wEWeFtwD0QjF-5WEjEcseWLqIxpJo-jEBuFBLPPuncTgbfG4V-yi4IuDmBJQ4WEkgUZOcQKb84V06iiZebWJOZtgUE2m9sfEfm8V9mz63g0Ik8W8bzNOCgfGeeHwhrg7AA7L8gcMEsMQSd0RlTITrX9lNp-j9X0seOBEbd_SvXq207DPpqYXeYKex1dvnedg3oa4Ul469vy9g2NfT0mCM0r6PoO-wwPRTgpOrfKWI67DQcjxFGlNIdfmQ1BxQkKaeBSIXs9BVzLa4XaF7D5q90buFi_aGT3cdY2DfYlgq5Rd18j_LUyMu1G4h2VVH0t7LTHha8jmjxt9uSweLy5FR9BZ1rZSZHCOOBBIIkd7K9dTQAdmrA-qROT9OpbgqLblfQTV6Bzba-G3mhcUoQ8XZkRErrkdHbA4kyfHhiQQsLZBx-IV2VDSVYDMOkl53MfvT9o_o4lUR_kOPIuXOHkhKCbswKAabEbM0xkiyYINCjDV0nspVZISNLga0ZWWLRgEfMwYg2Tv8WvHqozbBTxbM5DuLRg_flsA-qYtFA8qnWoUYyctYol4lbeMG_XxW_u01lBwwICg4Px1c6uUIPikUH6YWMbAkQTtFuV1jmKlmXRH7mr9QnRm4wjgIhJ3Qxfkki6Xiw5SYanYIPvxVIpo=w600-h800-s-no?authuser=1"]
                        ,
                           type: "Комната",
                           rooms: 1,
                           beds: 1,
                           capacity: 2,
                           owner_id: 1,
                           owner_name: "test",
                           price: 4000,
                           cancellation_policy: "za den",
                           free_dates: [DateResponse(month: 5, year: 2023, dates: [1,2,3,4,5,6,7]),
                                        DateResponse(month: 6, year: 2023, dates: [12,13,14,15,20,21,22,23,27,28,29]),
                                        DateResponse(month: 7, year: 2023, dates: [5,6,7,8,9,14,15,16,19,20,21,22,23,24,25,26,27,28])]
        )
    }
}

extension AccommodationSearchModel{
    static func mock() -> Self {
        AccommodationSearchModel(id: 1,
                                 type: "Дом",
                                 owner_id: 1,
                                 owner_name: "Вася Пупкин",
                                 image_preview: "https://lh3.googleusercontent.com/H_suXLNlLAqa6AhU7AP-v64NFExt71lelsIsnayYW-8OR5G8M27-2Wyc9RvWOcfnk4RyiROI5PzwDiPYeLDWf7m32Ns31Dag8bJSoGaJ33YiCPrkd6wTuhObcf2VfEqACGUHKh_CqHaE6gNRCnrkOVy_eEQo43zpzfjuQZH8rVWvoESuo_FJhMzGHsK6K_5g8nwN_vcgkTfBFHa9qr6HIcTVgWBT0YO5hfQj2w563MQmo-UgHmbGf0CtGeZ9OTeefdqJo4d8Hm-HQvZu4u_unC3-cTgRYDyHQDH42zWHlg2qSmv51rzl4mbv6HQdZg0ib5LYCJIM6UvRdXIJe-15bjj1rjkThsslkL3GF4LS3MuNcuUWymthUjB1rNbwVStcxu8XVx3xeB79CnhOeTCNB2XmHnQOGHP-70y3V727tiABaZzcKlqm9FQoUhrCPnHg-UbeP0QSc6LQ5pw4r0StAWFOWpmRSDIclaTV0FbpJg-0wrgFYmtVm7m-PdpzNFxtM2SBuY5UQMjP0xC_btvvbJ8fgGeTtbE9wEnHm9zs-FfXS2x0NJeuuGC-wiVs_cKEkUDCKto0FP444Wj7BBxe36bqnJrsMGMXmoeRcFMUUIR3urG7KJhJ__aZBjQKYk8eUZfE4DHXURvmHNPDXAytdRCQMSZp_ZVkYz33eJ761KZS8xxSpL1C5x1sqmxBmENWVGTQ86GwonZn6noFCMdzf8mfKiDdbgofPugWnCARa3ODT-qRQp7up4xV55fNBn8Av5yGHzm7Gpfc5AKXs353rfvfRzcnAXO316f5U8nSfpto_mL-Lw_2DJKWLsvSbPmD-6-DTSudqbU0u4_CBF7py1C1phGZ_d6SRXSXWxPYn8y3N8QBDLTVVU65k_CBeHWX4YUIuWyIY-oszgL9bB83DNctvwlufKlGE0-YZVYSesT-c6nQ-nwUdzayRFhNL5iFNgjRg9n6DInImUYn7QI=w600-h800-s-no?authuser=1",
                                 address: "г. Саратов, ул. Пушника, д. 17в",
                                 price: 5000)
    }
    
    static func mock2() -> Self {
        AccommodationSearchModel(id: 2,
                                 type: "Квартрира",
                                 owner_id: 1,
                                 owner_name: "Лошадь",
                                 image_preview: "https://exporealty.ru/upload/iblock/580/qiktucw85t4zl376ohcn99ev94iklgay/4.jpg",
                                 address: "г. Энгельс, ул. Кравцов, д. 21б",
                                 price: 10000)
    }
}

extension AccommodationBookingModel{
    static func mock() -> Self {
        AccommodationBookingModel(id: 3,
                                  booking_id: 3,
                                  type: "Квартира",
                                  owner_id: 4,
                                  owner_name: "Михаил Кукуруза",
                                  image_preview:  "https://darstroy-yug.ru/upload/medialibrary/571/5714b76c6608bb9e59d4bf4d2f03bb2d.jpg",
                                  images: ["https://remont-f.ru/upload/iblock/597/dizayn-interyera-kvartiry-v-sovremennom-stile-gostinaja-2.jpg",
                                           "https://salon.ru/storage/thumbs/gallery/272/271492/835_3500_s927.jpg",
                                           "https://evdom.ru/wp-content/uploads/2018/10/sovremennyj-dizajn-odnokomnatnoj-kvartiry-01-1000x750.jpg",
                                           "https://exporealty.ru/upload/iblock/580/qiktucw85t4zl376ohcn99ev94iklgay/4.jpg",
                                           "https://novostroyki.shop/wp-content/uploads/2021/01/2250619.jpg",
                                           "https://darstroy-yug.ru/upload/medialibrary/571/5714b76c6608bb9e59d4bf4d2f03bb2d.jpg"],
                                  price: 7882,
                                  booking_dates:  [DateResponse(month: 10, year: 2023, dates: [1,2,3,4,5,6,7]),
                                                   DateResponse(month: 11, year: 2023, dates: [12,13,14,15,20,21,22,23,27,28,29]),
                                                   DateResponse(month: 12, year: 2023, dates: [5,6,7,8,9,14,15,16,19,20,21,22,23,24,25,26,27,28])],
                                  address: "Лермонтова 7А")
    }
}

