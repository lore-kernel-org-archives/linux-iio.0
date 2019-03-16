Return-Path: <SRS0=kDFh=RT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F35FC43381
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 09:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112B42087C
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 09:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="zckVg6iW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfCPJQp (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 16 Mar 2019 05:16:45 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:36083 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfCPJQp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Mar 2019 05:16:45 -0400
Received: by mail-pf1-f176.google.com with SMTP id p10so1165216pff.3
        for <linux-iio@vger.kernel.org>; Sat, 16 Mar 2019 02:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:openpgp:autocrypt:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=94Nz2YcSh3xqYa4s0IdHV73fkGw0Oyhi3MaXFKJ/zjI=;
        b=zckVg6iWL5olF46FouazRVOMnL23fqegAb5Qqbda0WCd/FsX/zUWH70LJt53fNwhvz
         RM1xQM5H9mrqR7ATdzqpz48Yi+TiVfVR5fe//1Ji4BI0F4sxCjZHmFmt/5T63vMNfQtu
         /X978f0X+50z8W9e8m1H7xuQYBA1O8xD3n/Z10M5dbte7uo2003E5AwUswnLfdauCSId
         P3o+P0BL0XwTFSgkCgYaZOVW6gJz8utNClUYj35l+iDlMvk2atZDAdkD8yCHpRXjSthk
         A4B5x5+FdmwA0WcjIujcjtsWADysf8Wjs9vcbdjBQTTx2uREInGvLXxqrb5mGwLPH3et
         W+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=94Nz2YcSh3xqYa4s0IdHV73fkGw0Oyhi3MaXFKJ/zjI=;
        b=ScU6GZKup51Y6cRdOp8qx0rGCJV7eQl2Gt0rR8LNnehB880pUfZTY5UFRi1I6ERpIc
         mLuShyzKAY7PZeOFlgDWSJnznuWJbfyWVjeVOEyfNcpzbakREkGOPF+pg6D1th3D5I/X
         gf524dNhWaj0E3kjLFyVDsdh7O8L7fLUxyADO3SkGyjaNsCEP+PK2MFwSo4TdaHsGmF/
         kCk5fy7xB2pgHNhLUQCR11Z6hZ+FNw4znhqGfCEN/d4isQeDN4qI/ECcm6NWMjdAZy67
         6jXqS/6uQmtWgM+GHi/+kEmm+2KiepdtZkanIDKdZSTJj2liUoGZwnjy9tBXAJxGfo1y
         7rUA==
X-Gm-Message-State: APjAAAVJiAx8zW0ekWELQyJ9cHTk4WmVNNNLaf/vAM8pyp+LqrSNd1tn
        FXPKJmxRnp1uyIaQGaxM59H23Gh0GTc=
X-Google-Smtp-Source: APXvYqyCm0sbLIENPj1Mo/HEsA+DgTtDiOKfHeFyw1p5eS3KNGZ7UUgekyUYh+dfk1rlzDObWWteQg==
X-Received: by 2002:aa7:8150:: with SMTP id d16mr8609867pfn.172.1552727803840;
        Sat, 16 Mar 2019 02:16:43 -0700 (PDT)
Received: from [192.168.10.152] (124-171-140-5.dyn.iinet.net.au. [124.171.140.5])
        by smtp.gmail.com with ESMTPSA id k74sm10282653pfb.172.2019.03.16.02.16.41
        for <linux-iio@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 02:16:42 -0700 (PDT)
To:     linux-iio@vger.kernel.org
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Debugging 3D sensor on Lenovo YOGA 700-11ISK
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 mQINBE+rT0sBEADFEI2UtPRsLLvnRf+tI9nA8T91+jDK3NLkqV+2DKHkTGPP5qzDZpRSH6mD
 EePO1JqpVuIow/wGud9xaPA5uvuVgRS1q7RU8otD+7VLDFzPRiRE4Jfr2CW89Ox6BF+q5ZPV
 /pS4v4G9eOrw1v09lEKHB9WtiBVhhxKK1LnUjPEH3ifkOkgW7jFfoYgTdtB3XaXVgYnNPDFo
 PTBYsJy+wr89XfyHr2Ev7BB3Xaf7qICXdBF8MEVY8t/UFsesg4wFWOuzCfqxFmKEaPDZlTuR
 tfLAeVpslNfWCi5ybPlowLx6KJqOsI9R2a9o4qRXWGP7IwiMRAC3iiPyk9cknt8ee6EUIxI6
 t847eFaVKI/6WcxhszI0R6Cj+N4y+1rHfkGWYWupCiHwj9DjILW9iEAncVgQmkNPpUsZECLT
 WQzMuVSxjuXW4nJ6f4OFHqL2dU//qR+BM/eJ0TT3OnfLcPqfucGxubhT7n/CXUxEy+mvWwnm
 s9p4uqVpTfEuzQ0/bE6t7dZdPBua7eYox1AQnk8JQDwC3Rn9kZq2O7u5KuJP5MfludMmQevm
 pHYEMF4vZuIpWcOrrSctJfIIEyhDoDmR34bCXAZfNJ4p4H6TPqPh671uMQV82CfTxTrMhGFq
 8WYU2AH86FrVQfWoH09z1WqhlOm/KZhAV5FndwVjQJs1MRXD8QARAQABtCRBbGV4ZXkgS2Fy
 ZGFzaGV2c2tpeSA8YWlrQG96bGFicy5ydT6JAjgEEwECACIFAk+rT0sCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAAAoJEIYTPdgrwSC5fAIP/0wf/oSYaCq9PhO0UP9zLSEz66SSZUf7
 AM9O1rau1lJpT8RoNa0hXFXIVbqPPKPZgorQV8SVmYRLr0oSmPnTiZC82x2dJGOR8x4E01gK
 TanY53J/Z6+CpYykqcIpOlGsytUTBA+AFOpdaFxnJ9a8p2wA586fhCZHVpV7W6EtUPH1SFTQ
 q5xvBmr3KkWGjz1FSLH4FeB70zP6uyuf/B2KPmdlPkyuoafl2UrU8LBADi/efc53PZUAREih
 sm3ch4AxaL4QIWOmlE93S+9nHZSRo9jgGXB1LzAiMRII3/2Leg7O4hBHZ9Nki8/fbDo5///+
 kD4L7UNbSUM/ACWHhd4m1zkzTbyRzvL8NAVQ3rckLOmju7Eu9whiPueGMi5sihy9VQKHmEOx
 OMEhxLRQbzj4ypRLS9a+oxk1BMMu9cd/TccNy0uwx2UUjDQw/cXw2rRWTRCxoKmUsQ+eNWEd
 iYLW6TCfl9CfHlT6A7Zmeqx2DCeFafqEd69DqR9A8W5rx6LQcl0iOlkNqJxxbbW3ddDsLU/Y
 r4cY20++WwOhSNghhtrroP+gouTOIrNE/tvG16jHs8nrYBZuc02nfX1/gd8eguNfVX/ZTHiR
 gHBWe40xBKwBEK2UeqSpeVTohYWGBkcd64naGtK9qHdo1zY1P55lHEc5Uhlk743PgAnOi27Q
 ns5zuQINBE+rT0sBEACnV6GBSm+25ACT+XAE0t6HHAwDy+UKfPNaQBNTTt31GIk5aXb2Kl/p
 AgwZhQFEjZwDbl9D/f2GtmUHWKcCmWsYd5M/6Ljnbp0Ti5/xi6FyfqnO+G/wD2VhGcKBId1X
 Em/B5y1kZVbzcGVjgD3HiRTqE63UPld45bgK2XVbi2+x8lFvzuFq56E3ZsJZ+WrXpArQXib2
 hzNFwQleq/KLBDOqTT7H+NpjPFR09Qzfa7wIU6pMNF2uFg5ihb+KatxgRDHg70+BzQfa6PPA
 o1xioKXW1eHeRGMmULM0Eweuvpc7/STD3K7EJ5bBq8svoXKuRxoWRkAp9Ll65KTUXgfS+c0x
 gkzJAn8aTG0z/oEJCKPJ08CtYQ5j7AgWJBIqG+PpYrEkhjzSn+DZ5Yl8r+JnZ2cJlYsUHAB9
 jwBnWmLCR3gfop65q84zLXRQKWkASRhBp4JK3IS2Zz7Nd/Sqsowwh8x+3/IUxVEIMaVoUaxk
 Wt8kx40h3VrnLTFRQwQChm/TBtXqVFIuv7/Mhvvcq11xnzKjm2FCnTvCh6T2wJw3de6kYjCO
 7wsaQ2y3i1Gkad45S0hzag/AuhQJbieowKecuI7WSeV8AOFVHmgfhKti8t4Ff758Z0tw5Fpc
 BFDngh6Lty9yR/fKrbkkp6ux1gJ2QncwK1v5kFks82Cgj+DSXK6GUQARAQABiQIfBBgBAgAJ
 BQJPq09LAhsMAAoJEIYTPdgrwSC5NYEP/2DmcEa7K9A+BT2+G5GXaaiFa098DeDrnjmRvumJ
 BhA1UdZRdfqICBADmKHlJjj2xYo387sZpS6ABbhrFxM6s37g/pGPvFUFn49C47SqkoGcbeDz
 Ha7JHyYUC+Tz1dpB8EQDh5xHMXj7t59mRDgsZ2uVBKtXj2ZkbizSHlyoeCfs1gZKQgQE8Ffc
 F8eWKoqAQtn3j4nE3RXbxzTJJfExjFB53vy2wV48fUBdyoXKwE85fiPglQ8bU++0XdOr9oyy
 j1llZlB9t3tKVv401JAdX8EN0++ETiOovQdzE1m+6ioDCtKEx84ObZJM0yGSEGEanrWjiwsa
 nzeK0pJQM9EwoEYi8TBGhHC9ksaAAQipSH7F2OHSYIlYtd91QoiemgclZcSgrxKSJhyFhmLr
 QEiEILTKn/pqJfhHU/7R7UtlDAmFMUp7ByywB4JLcyD10lTmrEJ0iyRRTVfDrfVP82aMBXgF
 tKQaCxcmLCaEtrSrYGzd1sSPwJne9ssfq0SE/LM1J7VdCjm6OWV33SwKrfd6rOtvOzgadrG6
 3bgUVBw+bsXhWDd8tvuCXmdY4bnUblxF2B6GOwSY43v6suugBttIyW5Bl2tXSTwP+zQisOJo
 +dpVG2pRr39h+buHB3NY83NEPXm1kUOhduJUA17XUY6QQCAaN4sdwPqHq938S3EmtVhsuQIN
 BFq54uIBEACtPWrRdrvqfwQF+KMieDAMGdWKGSYSfoEGGJ+iNR8v255IyCMkty+yaHafvzpl
 PFtBQ/D7Fjv+PoHdFq1BnNTk8u2ngfbre9wd9MvTDsyP/TmpF0wyyTXhhtYvE267Av4X/BQT
 lT9IXKyAf1fP4BGYdTNgQZmAjrRsVUW0j6gFDrN0rq2J9emkGIPvt9rQt6xGzrd6aXonbg5V
 j6Uac1F42ESOZkIh5cN6cgnGdqAQb8CgLK92Yc8eiCVCH3cGowtzQ2m6U32qf30cBWmzfSH0
 HeYmTP9+5L8qSTA9s3z0228vlaY0cFGcXjdodBeVbhqQYseMF9FXiEyRs28uHAJEyvVZwI49
 CnAgVV/n1eZa5qOBpBL+ZSURm8Ii0vgfvGSijPGbvc32UAeAmBWISm7QOmc6sWa1tobCiVmY
 SNzj5MCNk8z4cddoKIc7Wt197+X/X5JPUF5nQRvg3SEHvfjkS4uEst9GwQBpsbQYH9MYWq2P
 PdxZ+xQE6v7cNB/pGGyXqKjYCm6v70JOzJFmheuUq0Ljnfhfs15DmZaLCGSMC0Amr+rtefpA
 y9FO5KaARgdhVjP2svc1F9KmTUGinSfuFm3quadGcQbJw+lJNYIfM7PMS9fftq6vCUBoGu3L
 j4xlgA/uQl/LPneu9mcvit8JqcWGS3fO+YeagUOon1TRqQARAQABiQRsBBgBCAAgFiEEZSrP
 ibrORRTHQ99dhhM92CvBILkFAlq54uICGwICQAkQhhM92CvBILnBdCAEGQEIAB0WIQQIhvWx
 rCU+BGX+nH3N7sq0YorTbQUCWrni4gAKCRDN7sq0YorTbVVSD/9V1xkVFyUCZfWlRuryBRZm
 S4GVaNtiV2nfUfcThQBfF0sSW/aFkLP6y+35wlOGJE65Riw1C2Ca9WQYk0xKvcZrmuYkK3DZ
 0M9/Ikkj5/2v0vxz5Z5w/9+IaCrnk7pTnHZuZqOh23NeVZGBls/IDIvvLEjpD5UYicH0wxv+
 X6cl1RoP2Kiyvenf0cS73O22qSEw0Qb9SId8wh0+ClWet2E7hkjWFkQfgJ3hujR/JtwDT/8h
 3oCZFR0KuMPHRDsCepaqb/k7VSGTLBjVDOmr6/C9FHSjq0WrVB9LGOkdnr/xcISDZcMIpbRm
 EkIQ91LkT/HYIImL33ynPB0SmA+1TyMgOMZ4bakFCEn1vxB8Ir8qx5O0lHMOiWMJAp/PAZB2
 r4XSSHNlXUaWUg1w3SG2CQKMFX7vzA31ZeEiWO8tj/c2ZjQmYjTLlfDK04WpOy1vTeP45LG2
 wwtMA1pKvQ9UdbYbovz92oyZXHq81+k5Fj/YA1y2PI4MdHO4QobzgREoPGDkn6QlbJUBf4To
 pEbIGgW5LRPLuFlOPWHmIS/sdXDrllPc29aX2P7zdD/ivHABslHmt7vN3QY+hG0xgsCO1JG5
 pLORF2N5XpM95zxkZqvYfC5tS/qhKyMcn1kC0fcRySVVeR3tUkU8/caCqxOqeMe2B6yTiU1P
 aNDq25qYFLeYxg67D/4w/P6BvNxNxk8hx6oQ10TOlnmeWp1q0cuutccblU3ryRFLDJSngTEu
 ZgnOt5dUFuOZxmMkqXGPHP1iOb+YDznHmC0FYZFG2KAc9pO0WuO7uT70lL6larTQrEneTDxQ
 CMQLP3qAJ/2aBH6SzHIQ7sfbsxy/63jAiHiT3cOaxAKsWkoV2HQpnmPOJ9u02TPjYmdpeIfa
 X2tXyeBixa3i/6dWJ4nIp3vGQicQkut1YBwR7dJq67/FCV3Mlj94jI0myHT5PIrCS2S8LtWX
 ikTJSxWUKmh7OP5mrqhwNe0ezgGiWxxvyNwThOHc5JvpzJLd32VDFilbxgu4Hhnf6LcgZJ2c
 Zd44XWqUu7FzVOYaSgIvTP0hNrBYm/E6M7yrLbs3JY74fGzPWGRbBUHTZXQEqQnZglXaVB5V
 ZhSFtHopZnBSCUSNDbB+QGy4B/E++Bb02IBTGl/JxmOwG+kZUnymsPvTtnNIeTLHxN/H/ae0
 c7E5M+/NpslPCmYnDjs5qg0/3ihh6XuOGggZQOqrYPC3PnsNs3NxirwOkVPQgO6mXxpuifvJ
 DG9EMkK8IBXnLulqVk54kf7fE0jT/d8RTtJIA92GzsgdK2rpT1MBKKVffjRFGwN7nQVOzi4T
 XrB5p+6ML7Bd84xOEGsj/vdaXmz1esuH7BOZAGEZfLRCHJ0GVCSssg==
Message-ID: <eb33acca-f48d-a689-c5e7-6f9b66f50caf@ozlabs.ru>
Date:   Sat, 16 Mar 2019 20:16:39 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

I got a quite old Lenovo YOGA 700-11ISK with flip screen and run
fedora29 on it. I found that gnome3 cannot properly detect the screen
orientation and the screen keeps rotating non stop.

I opened an issue agains iio-sensor-proxy, not much luck there.
https://github.com/hadess/iio-sensor-proxy/issues/220

I resumed my debugging and the situation seems improving.

The yoga is running fedora29 v4.20.14. The fedora's iio-sensor-proxy
still has this problem and so does the iio-sensor-proxy upstream version.

Then I commented out &iio_buffer_accel to make &iio_poll_accel work -
and things worked nicely. I looked in sysfs and in_accel_?_raw seem to
have correct values (same as in the first log below, give or take), all
good. Recorded some debug from iio-sensor-proxy:

Accel read from IIO on 'accel_3d': -39, -937, -378 (scale 0.009807)
Accel sent by driver (quirk applied): -39, -937, -378 (scale: 0.009807)
Emitted orientation changed: from undefined to normal
No new data available on 'iio:device3'
Accel read from IIO on 'accel_3d': -39, -933, -371 (scale 0.009807)
Accel sent by driver (quirk applied): -39, -933, -371 (scale: 0.009807)
No new data available on 'iio:device3'
Accel read from IIO on 'accel_3d': -39, -933, -367 (scale 0.009807)
Accel sent by driver (quirk applied): -39, -933, -367 (scale: 0.009807)

This is the good log, gnome works fine.


Then I recorded debug with the buffer driver enabled:

rocess_scan_1: channel_index: 0, chan_name: in_accel_x,
channel_data_index: 0 location: 0
process_scan_1: channel_index: 1, chan_name: in_accel_y,
channel_data_index: 1 location: 4
process_scan_1: channel_index: 2, chan_name: in_accel_z,
channel_data_index: 2 location: 8
Accel read from IIO on 'iio:device4': -15, -898, -375 (scale 0.009807)
Accel sent by driver (quirk applied): -15, -898, -375 (scale: 0.009807)
Emitted orientation changed: from undefined to normal
No new data available on 'iio:device3'
process_scan_1: channel_index: 0, chan_name: in_accel_x,
channel_data_index: 0 location: 0
process_scan_1: channel_index: 1, chan_name: in_accel_y,
channel_data_index: 1 location: 4
process_scan_1: channel_index: 2, chan_name: in_accel_z,
channel_data_index: 2 location: 8
Accel read from IIO on 'iio:device4': 20774, 27203, 0 (scale 0.009807)
Accel sent by driver (quirk applied): 20774, 27203, 0 (scale: 0.009807)
Emitted orientation changed: from normal to left-up
No new data available on 'iio:device3'
process_scan_1: channel_index: 0, chan_name: in_accel_x,
channel_data_index: 0 location: 0
process_scan_1: channel_index: 1, chan_name: in_accel_y,
channel_data_index: 1 location: 4
process_scan_1: channel_index: 2, chan_name: in_accel_z,
channel_data_index: 2 location: 8
Accel read from IIO on 'iio:device4': -31, -929, -398 (scale 0.009807)
Accel sent by driver (quirk applied): -31, -929, -398 (scale: 0.009807)
Emitted orientation changed: from left-up to normal
No new data available on 'iio:device3'
process_scan_1: channel_index: 0, chan_name: in_accel_x,
channel_data_index: 0 location: 0
process_scan_1: channel_index: 1, chan_name: in_accel_y,
channel_data_index: 1 location: 4
process_scan_1: channel_index: 2, chan_name: in_accel_z,
channel_data_index: 2 location: 8
Accel read from IIO on 'iio:device4': -14345, -32024, 12738 (scale 0.009807)
Accel sent by driver (quirk applied): -14345, -32024, 12738 (scale:
0.009807)

So it is good reading, bad reading, good reading, bad reading, and gnome
rotates the screen non stop. No wonder gnome3 goes crazy.

I would debug further and even come up with a fix but I failed to find
quickly where there reads are handled in the kernel, and what defines
these in_accel_?_raw files in sysfs, tried grepping - nothing. Any pointers?


Also, how do I identify my particular 3d sensor? Or it is the same model
everywhere? Or it is the driver for all of them?

Here is dmesg | grep i2c:

[root@aikyoga iio:device4]# dmesg | egrep '(i2c|iio)'
[    5.389867] i2c_hid i2c-ITE8350:00: i2c-ITE8350:00 supply vdd not
found, using dummy regulator
[    5.389893] i2c_hid i2c-ITE8350:00: Linked as a consumer to regulator.0
[    5.389896] i2c_hid i2c-ITE8350:00: i2c-ITE8350:00 supply vddl not
found, using dummy regulator
[    5.502896] hid-generic 0018:048D:8350.0002: hidraw1: I2C HID v1.00
Device [ITE8350:00 048D:8350] on i2c-ITE8350:00
[    5.528455] i2c_hid i2c-SYNA2B23:00: i2c-SYNA2B23:00 supply vdd not
found, using dummy regulator
[    5.528485] i2c_hid i2c-SYNA2B23:00: Linked as a consumer to regulator.0
[    5.528489] i2c_hid i2c-SYNA2B23:00: i2c-SYNA2B23:00 supply vddl not
found, using dummy regulator
[    5.543440] input: SYNA2B23:00 06CB:2714 Mouse as
/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-6/i2c-SYNA2B23:00/0018:06CB:2714.0003/input/input13
[    5.543690] hid-generic 0018:06CB:2714.0003: input,hidraw2: I2C HID
v1.00 Mouse [SYNA2B23:00 06CB:2714] on i2c-SYNA2B23:00
[    6.053237] input: Synaptics TM2714-002 as
/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-6/i2c-SYNA2B23:00/0018:06CB:2714.0003/input/input16
[    6.053444] hid-rmi 0018:06CB:2714.0003: input,hidraw1: I2C HID v1.00
Mouse [SYNA2B23:00 06CB:2714] on i2c-SYNA2B23:00

Thanks!


-- 
Alexey
