Return-Path: <SRS0=diYI=OZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B40C43387
	for <linux-iio@archiver.kernel.org>; Sun, 16 Dec 2018 15:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1912086C
	for <linux-iio@archiver.kernel.org>; Sun, 16 Dec 2018 15:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtSAyWOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbeLPP7L (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 16 Dec 2018 10:59:11 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:41560 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbeLPP7K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Dec 2018 10:59:10 -0500
Received: by mail-pg1-f170.google.com with SMTP id m1so3283251pgq.8
        for <linux-iio@vger.kernel.org>; Sun, 16 Dec 2018 07:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2MhqKNsjG2+V6QaYGZKpj0rIWTnDbHp/n9BcIiYrzgk=;
        b=FtSAyWOBo+RVSK4VffV4RQmc/pRqsGtF/p+XFCX4a14k5CTRmXQSEBcyWrD7i/PU0i
         s7kYe3eLNNUQq+3HHmfKHR82S5BB2GD5zDqyedu9xZaYiCjUeDOD+RQZLGgmo8AhNwwL
         C7m3tdr3z/2Ao9DF5xLTf3Smnw75Ga9UdmprS+sI/vQHIShiiKqMjAMk3fhb/gzZsibm
         qpWzUrdZn2aZmNjBznWVuHaj8Cz5+9qGkJUzrRjV6q4/W/yfDIKun0MqgqscdJ2nvlFH
         UfuQJv0j5je6K//jdkxWO9/A3ZhPITobXN0omrqYg774VCGkl4gob9Un0+oVvmJJ1IvU
         vMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2MhqKNsjG2+V6QaYGZKpj0rIWTnDbHp/n9BcIiYrzgk=;
        b=TSPnEE9JhOhTPBC8KNxUK8N6SHhHLVUBBXFGJqICDxt5suVgfKR9YQ24Zho4b40F5X
         RZO5XYDm69JoVV9j0zVopOD5/OLUbCkgKHFoAd9w9lHkJ3TTBrBoBsoZrC5V169uTpow
         0Ph/sZA4WCjL33WYvaWdH62VDp5Yj77cnJH3aiafiKdedpw0dll3PMiSxEhVQkHcQ3zz
         dtRMGCvW6/E5uF6fTIZs7+D6toP8bCN05YnDh9K3Irk9FgPftW2IAncrZbsOyBxquTRR
         IGi+ZcS73HiChCNtohwsXKVUD0p1o7WATEa23fVjDsVOxrfJsYyoZEitWweKu42hf0B3
         unkQ==
X-Gm-Message-State: AA+aEWZ1m2nzfUk6W5tQ/9RUvsrwcC8PwKv0fmT+HVZClDuaKMDqoVIc
        EX4pVYlV03o2uGP5KHhqHh8=
X-Google-Smtp-Source: AFSGD/WZw4rK8PPduI7iUXr85K7GzdsrLzXIBn1NCHETHYiJXI5FCcIH5QztzKE6/Ui0HwFTTVcPVg==
X-Received: by 2002:a63:b34f:: with SMTP id x15mr9442420pgt.243.1544975948673;
        Sun, 16 Dec 2018 07:59:08 -0800 (PST)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id h64sm15739594pfc.142.2018.12.16.07.59.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 07:59:07 -0800 (PST)
Date:   Sun, 16 Dec 2018 21:29:00 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Tuukka Pasanen <pasanen.tuukka@gmail.com>
Cc:     linux-iio@vger.kernel.org, dpfrey@gmail.com
Subject: Re: IIO BME680 driver
Message-ID: <20181216155900.GA19465@himanshu-Vostro-3559>
References: <712905bc-4d81-0b38-44d6-d4f31f08c3ae@gmail.com>
 <20181215191743.GA1263@himanshu-Vostro-3559>
 <6f1d36a0-f059-4c8b-4497-12c9b2c73a12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f1d36a0-f059-4c8b-4497-12c9b2c73a12@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Dec 16, 2018 at 04:39:40PM +0200, Tuukka Pasanen wrote:
> Hello,
> 
> Hmm. Why would anyone want to play with those calibration constants
> > programmed into the NVM of the sensor.
> > 
> > And I wonder how the following came up ?
> > https://github.com/pimoroni/bme680-python/blob/e827e5d622fd70df2aee6a68ebac626cf539ee55/library/bme680/__init__.py#L331
> > 
> > These algorithms are provided by Bosch and probably should be used as-is
> > unless you got some information from them. But I don't see any such
> > reference in the datasheet nor in their API.
> I think noone wants to tough those defaults. BME680 as said work as
> expected. Idea behind that line is when it's not getting correct value for
> temperature one adjust that little bit. It's ugly and it's not what
> datasheet or API tolds us todo but it's practical.

OK.
I will give it a try sometime but I that would need a separate
temperature sensor to compare and identify any false readings.

> > Or it might be some heuristics. Not sure about it!
> > 
> > > This one adjust temperature every time one reads it. For example my room
> > > temperature is something like 21C (I live in north) and BME680 reports 28C
> > > so humidity and pressure are incorrect (not much but notable).
> > Now since you're using IIO driver, I see the problem here:
> > https://github.com/torvalds/linux/blob/master/drivers/iio/chemical/bme680.h#L52
> > 
> > 	#define BME680_AMB_TEMP				25
> > 
> > Yes, it is hardcoded here and you should change it to according to your
> > room temperature(20-21 degC).
> Could this one turn into module parameter as it would be more convenient? As
> it's hard breaking in year 2019 to recompile kernel to make it fit to your
> room temperature. I can compile for testing but as I can imagine most of the
> earth population won't do it.

Indeed!

I will add an attribute which user can write just like we set the
oversampling ratios.

Or I may try the taking the initial temperaure as the ambient temperature.

> > There are two things that I shall be soon working on as soon as my
> > current work with Zephyr ends:
> > 
> > 1. add profile duration function
> > 2. check for new available data before fetching
> >   ... and more if anything comes up.
> 
> One thing that should be addressed is that if you only read one measurement
> and go to sleep then your VOC is incorrect as it needs 5 mins or something
> to warm up. Of course I can read very rapidly to make that work and I assume
> that thread in mailing list with continous stream is all about that.

5 mins ? Are you sure ?

Datasheet:
---------

"The heating duration is specified by writing to the corresponding 
gas_wait_x<7:0> control register. Heating durations between 1 ms 
and 4032 ms can be configured. In practice, approximately 20–30 ms 
are necessary for the heater to reach the intended target temperature."

For ensuring that the heater sink is heated to the target temperature, I
added the following in the driver, and if it fails to do that we just
abort:

<snip>

729         /*
730          * occurs if either the gas heating duration was insuffient
731          * to reach the target heater temperature or the target
732          * heater temperature was too high for the heater sink to
733          * reach.
734          */
735         if ((check & BME680_GAS_STAB_BIT) == 0) {
736                 dev_err(dev, "heater failed to reach the target temperature\n");
737                 return -EINVAL;
738         }

</snip>

And now I wonder that -EINVAL isn't the best way to represent such a
failure. -ERETRY or something more appropriate should have been used.

That thread was about adding power management support + triggered buffer
support.

Device is already power managed as it automatically goes to sleep mode
soon after a single TPHG cycle is performed.

OTOH, I'm not brave and smart enough to add triggered buffer support
even after the long string of email threads.

> > Bosch claimed that new datasheet shall be soon be available with all the
> > missing info, and then anyone wouldn't need to reverse engineer their API
> > or BSEC to get the desired info :P
> Hopefully this comes sooner than later as it would make things more easier
> > Thank you for using the IIO driver and I'm glad that there are users out
> > there testing it. Please let me know if there are any more issues :)
> 
> No problem.. I'll try to make it work as that Python library but I have to
> over come these few problems.

Sorry! I will try to recticy those and others that I have in mind, but
might not quick about it.


-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
