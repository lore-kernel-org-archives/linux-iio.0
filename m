Return-Path: <SRS0=diYI=OZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B213C43387
	for <linux-iio@archiver.kernel.org>; Sun, 16 Dec 2018 14:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3812086C
	for <linux-iio@archiver.kernel.org>; Sun, 16 Dec 2018 14:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhD2UTOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbeLPOjo (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 16 Dec 2018 09:39:44 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:37699 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbeLPOjo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Dec 2018 09:39:44 -0500
Received: by mail-lf1-f53.google.com with SMTP id y11so7590766lfj.4
        for <linux-iio@vger.kernel.org>; Sun, 16 Dec 2018 06:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0ziK7/Iz0PPvthPCvrWt3gfzAm+QSYa/+3DBvHPZBfM=;
        b=PhD2UTOaLp7Q2M+RO9yaEjq/b9/9aRLNgig2rDyulPkjTAW25lvigEUThs8ziGgmz0
         qfo35luw2xm8myVsJ/m3ffPRwF0SF1gQOMkkWfoDAtG7UXmQwg5un6lTgZa9OKxXz8Hz
         TPWT2y71kRHdU77g32nF6fJlokb4VO+rc17K2JByI4By4RaF3D8cuwwBUYrEPeEEq2+j
         zWFuxIUypMJvoAeyFhokchpI5Rhoinqs0R+t0tC4DaieeLoHI9vfNlKmC+r3cstRyP1l
         4u4x7oHPmWQUWGcYJxYr0QdSJbuOKenQsudtJdzUFs+YbgEt31qG2v/aEFPJw4QG4FTq
         AogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0ziK7/Iz0PPvthPCvrWt3gfzAm+QSYa/+3DBvHPZBfM=;
        b=nioTKdhTq8wBu0GWlO8GiS3z/AwlBl6GLGe0KBzEFzugbHo93I2sW8sqp2it4cJJJm
         ivtMwj+iXIQRycqjJphns2ElfnALykfv5x5DdcJ9ZtXSdCZQE1sipFlhPis4lY735KID
         oTsJ1dUmlIKVGQFLJOyGAaT3r3hj5CJBVq0+rBfPbymisikB7UrlG2HUIdnVeUDBHAxh
         ADC8l/lpA9Fd9zphru3N27f0eJpHef9or5pFFG6FR6U2HZZVsGvjOWty9pyKoOnRxUua
         eEPXVf6ikFTW2bbvGy/KQ/rRpoBG/BtkRRDlhdTzLrrmqMGe8pBCoZoURAxaWefmuMU7
         SqUQ==
X-Gm-Message-State: AA+aEWYLHRt7cOcJEhouOBtmCKW75D0lH7GT6kMMkf9VYLwG85MG41Wa
        v/bFXS1dT3aV01BgmgZtpqs=
X-Google-Smtp-Source: AFSGD/WcBOvr+ad1CPwAzwqPgG9BBb8BXndYSipt8qUozrhUeSDM+AddPDPvqlzLDtR3zqy12uE+2w==
X-Received: by 2002:a19:ae03:: with SMTP id f3mr5761273lfc.86.1544971182411;
        Sun, 16 Dec 2018 06:39:42 -0800 (PST)
Received: from [192.168.8.103] (188-67-112-9.bb.dnainternet.fi. [188.67.112.9])
        by smtp.googlemail.com with ESMTPSA id k11-v6sm2008269ljk.40.2018.12.16.06.39.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 06:39:41 -0800 (PST)
Subject: Re: IIO BME680 driver
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     linux-iio@vger.kernel.org, dpfrey@gmail.com
References: <712905bc-4d81-0b38-44d6-d4f31f08c3ae@gmail.com>
 <20181215191743.GA1263@himanshu-Vostro-3559>
From:   Tuukka Pasanen <pasanen.tuukka@gmail.com>
Message-ID: <6f1d36a0-f059-4c8b-4497-12c9b2c73a12@gmail.com>
Date:   Sun, 16 Dec 2018 16:39:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181215191743.GA1263@himanshu-Vostro-3559>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

Hmm. Why would anyone want to play with those calibration constants
> programmed into the NVM of the sensor.
>
> And I wonder how the following came up ?
> https://github.com/pimoroni/bme680-python/blob/e827e5d622fd70df2aee6a68ebac626cf539ee55/library/bme680/__init__.py#L331
>
> These algorithms are provided by Bosch and probably should be used as-is
> unless you got some information from them. But I don't see any such
> reference in the datasheet nor in their API.
I think noone wants to tough those defaults. BME680 as said work as 
expected. Idea behind that line is when it's not getting correct value 
for temperature one adjust that little bit. It's ugly and it's not what 
datasheet or API tolds us todo but it's practical.
> Or it might be some heuristics. Not sure about it!
>
>> This one adjust temperature every time one reads it. For example my room
>> temperature is something like 21C (I live in north) and BME680 reports 28C
>> so humidity and pressure are incorrect (not much but notable).
> Now since you're using IIO driver, I see the problem here:
> https://github.com/torvalds/linux/blob/master/drivers/iio/chemical/bme680.h#L52
>
> 	#define BME680_AMB_TEMP				25
>
> Yes, it is hardcoded here and you should change it to according to your
> room temperature(20-21 degC).
Could this one turn into module parameter as it would be more 
convenient? As it's hard breaking in year 2019 to recompile kernel to 
make it fit to your room temperature. I can compile for testing but as I 
can imagine most of the earth population won't do it.
> There are two things that I shall be soon working on as soon as my
> current work with Zephyr ends:
>
> 1. add profile duration function
> 2. check for new available data before fetching
>   ... and more if anything comes up.

One thing that should be addressed is that if you only read one 
measurement and go to sleep then your VOC is incorrect as it needs 5 
mins or something to warm up. Of course I can read very rapidly to make 
that work and I assume that thread in mailing list with continous stream 
is all about that.

> Bosch claimed that new datasheet shall be soon be available with all the
> missing info, and then anyone wouldn't need to reverse engineer their API
> or BSEC to get the desired info :P
Hopefully this comes sooner than later as it would make things more easier
> Thank you for using the IIO driver and I'm glad that there are users out
> there testing it. Please let me know if there are any more issues :)

No problem.. I'll try to make it work as that Python library but I have 
to over come these few problems.

Sincerely,

Tuukka

