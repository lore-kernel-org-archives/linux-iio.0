Return-Path: <SRS0=mvch=O5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42152C43387
	for <linux-iio@archiver.kernel.org>; Thu, 20 Dec 2018 07:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B012176F
	for <linux-iio@archiver.kernel.org>; Thu, 20 Dec 2018 07:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9qJBT+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbeLTHlB (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 20 Dec 2018 02:41:01 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:42032 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbeLTHlA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Dec 2018 02:41:00 -0500
Received: by mail-lj1-f178.google.com with SMTP id l15-v6so632823lja.9
        for <linux-iio@vger.kernel.org>; Wed, 19 Dec 2018 23:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=OlBvt53tt7vkfNH26PD+R0NJn7mduTKOVaeDsEbxtBQ=;
        b=S9qJBT+b6MX0gMoRsgw2tPz92X/tD9CQYuD2+3gB1xYRzyvjT4PxJDLhyAc8igBqsQ
         ou78ncij1TUHqNjMHpp9R/mqsdKvAblmai7V4UlnfEStbbvYJb5L78XG0ORy6zpk/v2h
         im3BtNA/kWUbExDVVXHJLQZg3RTJdO+vUzDrUeuOFgvGmsbA1Wcr0jN5Qo9AyKsKrJH9
         5FryPyN66FdSFw6I7ROB8p9L1pmKvYoBj4UF5/YACifWkrDxudLgU6oSqmgpa29dYoUd
         4XsicmENV6zlIKz7F+zPsJkc6NF8WPbW5P/fviDafTVr/rF9j1J/IsYNIKaOwGHniHSp
         kYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OlBvt53tt7vkfNH26PD+R0NJn7mduTKOVaeDsEbxtBQ=;
        b=TgVG00f/P+ZIF5XncMtJFgGakOrYGCIJWCB8pnxZA4L934PqYrL6cbZt2sJ5oWMetM
         obn/wf3/pfd03g5p2wbtJz35iiZuEHBKZLLYl1uH6P/DJ7S/6oQ7EZ/YhLWgX2RYdLtl
         t/LmgaG47bBTus7WB8meFJkHvwajfXDvk8XdWQZ+N6jJRwtqBDMcCo9S0mfFtUHD5sqt
         vWs0A+rcccwX5DNoLOfCHZVC1GlITu7j/3fWe3Htfxaee2N85QvMzZOmzGGp3+RUwZq7
         6My6LELz2QY10meN78+iKKvEZrUqCv1fmUDldvb2z2H3R2GIWPyvBl+JNZAZ5xNHRMa4
         tUog==
X-Gm-Message-State: AA+aEWak9z9i/LC+lXyL7Q5YlIPUGcUvXdHXvKmWLzwsRHnrU/CNpgwa
        Cb8kxjpYll76/ry+j48aayQ=
X-Google-Smtp-Source: AFSGD/Uz0FfrNzOaXeIc7TOqoYquoghHmDZRkZ3JFVjoqArVFPd9DGAfCp7YUmtb4/L0I82mqb90Yw==
X-Received: by 2002:a2e:3308:: with SMTP id d8-v6mr1073294ljc.38.1545291658571;
        Wed, 19 Dec 2018 23:40:58 -0800 (PST)
Received: from [192.168.128.162] (85-76-113-206-nat.elisa-mobile.fi. [85.76.113.206])
        by smtp.googlemail.com with ESMTPSA id g4-v6sm4031468lji.17.2018.12.19.23.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 23:40:57 -0800 (PST)
Subject: Re: IIO BME680 driver
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     linux-iio@vger.kernel.org, dpfrey@gmail.com
References: <712905bc-4d81-0b38-44d6-d4f31f08c3ae@gmail.com>
 <20181215191743.GA1263@himanshu-Vostro-3559>
 <6f1d36a0-f059-4c8b-4497-12c9b2c73a12@gmail.com>
 <20181216155900.GA19465@himanshu-Vostro-3559>
From:   Tuukka Pasanen <pasanen.tuukka@gmail.com>
Message-ID: <53682349-3998-63a7-db0f-ebd23eff6167@gmail.com>
Date:   Thu, 20 Dec 2018 09:40:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181216155900.GA19465@himanshu-Vostro-3559>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,


>> One thing that should be addressed is that if you only read one measurement
>> and go to sleep then your VOC is incorrect as it needs 5 mins or something
>> to warm up. Of course I can read very rapidly to make that work and I assume
>> that thread in mailing list with continous stream is all about that.
> 5 mins ? Are you sure ?
>
> Datasheet:
> ---------
>
> "The heating duration is specified by writing to the corresponding
> gas_wait_x<7:0> control register. Heating durations between 1 ms
> and 4032 ms can be configured. In practice, approximately 20–30 ms
> are necessary for the heater to reach the intended target temperature."
>
> For ensuring that the heater sink is heated to the target temperature, I
> added the following in the driver, and if it fails to do that we just
> abort:
>
> <snip>
>
> 729         /*
> 730          * occurs if either the gas heating duration was insuffient
> 731          * to reach the target heater temperature or the target
> 732          * heater temperature was too high for the heater sink to
> 733          * reach.
> 734          */
> 735         if ((check & BME680_GAS_STAB_BIT) == 0) {
> 736                 dev_err(dev, "heater failed to reach the target temperature\n");
> 737                 return -EINVAL;
> 738         }
>
> </snip>
>
> And now I wonder that -EINVAL isn't the best way to represent such a
> failure. -ERETRY or something more appropriate should have been used.
>
> That thread was about adding power management support + triggered buffer
> support.
>
> Device is already power managed as it automatically goes to sleep mode
> soon after a single TPHG cycle is performed.
>
> OTOH, I'm not brave and smart enough to add triggered buffer support
> even after the long string of email threads.
I don't know about data-sheet but when you rapidly read BME680 then 
resistance in VOC reader tends to rise something like 3-5 mins and then 
you can get 'correct' reading (rising stops in somepoint). To have 
something in kernel under public eye is brave enough :). But I have to 
investigate data-sheet better and see if I am doing something very very 
stupid and heater just heats up.
>>> Bosch claimed that new datasheet shall be soon be available with all the
>>> missing info, and then anyone wouldn't need to reverse engineer their API
>>> or BSEC to get the desired info :P
>> Hopefully this comes sooner than later as it would make things more easier
>>> Thank you for using the IIO driver and I'm glad that there are users out
>>> there testing it. Please let me know if there are any more issues :)
>> No problem.. I'll try to make it work as that Python library but I have to
>> over come these few problems.
> Sorry! I will try to recticy those and others that I have in mind, but
> might not quick about it.

No worries, take you time as I have 'working' solution and I can test 
new features as they appear as I have personal interest about this.

Sincerely,

Tuukka

