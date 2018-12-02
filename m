Return-Path: <SRS0=4vqF=OL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EE5C04EB8
	for <linux-iio@archiver.kernel.org>; Sun,  2 Dec 2018 12:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4832082F
	for <linux-iio@archiver.kernel.org>; Sun,  2 Dec 2018 12:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4832082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbeLBMpv (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 2 Dec 2018 07:45:51 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:33144 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbeLBMpv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Dec 2018 07:45:51 -0500
Received: by mail-wr1-f51.google.com with SMTP id c14so9411260wrr.0
        for <linux-iio@vger.kernel.org>; Sun, 02 Dec 2018 04:45:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eS2zQK3OTyBnSNXxZV4x2ckHn9ndtZ07DnqXs0bzcM8=;
        b=N6beMprv+dD54gbDHhYkdrmx2uVgrZapJbUZ9dhNq2tGUSvAiy7Eh9+Z4hM8idCVi0
         hygR5zR6rAtwNjGzumSICFAr5EgrC/a2HoNKhKid5r072LSEZBBbdhgVatctaPf9Y5KH
         6RVgkK+c9PzkGVSktfEJ1pPIMQZx/VN3esqVNBnC1El+Btir3VlPmiQ4EQcKpbZCZjMy
         0Ipn6jRthDAEMInluJnwQuSK3bSXodjMNPSErx50wwyGA99bB8ytkqz2kbZKW3P5S9Mc
         U4qAPVEYzhoI0jOchJFzyA25F4Ve1IR/dB8aEekQVV/izHaKlDjhEyRZVncZa+FhSIEO
         luQA==
X-Gm-Message-State: AA+aEWYA76oAUTprIqhmnXOQTzxURDttv1n++I47xZJI7DNb21QIZC9u
        1ZFZ2wEqyhvexSU3AawGBJUVnQ==
X-Google-Smtp-Source: AFSGD/UDY2qqKhmVKUi0YWwl1RuclSJtSNh1u0zcmwfJMyzm0IwZ8TBgFRE2LqycpYu4Kw2Dc8usWw==
X-Received: by 2002:adf:fb4c:: with SMTP id c12mr10210350wrs.297.1543754747148;
        Sun, 02 Dec 2018 04:45:47 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id c129sm3451018wma.48.2018.12.02.04.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 04:45:46 -0800 (PST)
Subject: Re: Inconsistent SMO8840 accelerometer data between Windows and Linux
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Daniel Drake <drake@endlessm.com>
Cc:     linux-iio@vger.kernel.org, denis.ciocca@st.com,
        Bastien Nocera <hadess@hadess.net>, linux@endlessm.com
References: <CAD8Lp45Ds3VU70kQ7fAUAegbzL-asxmF_iBacWpu7DMKp65sGA@mail.gmail.com>
 <20181201162852.7007d1c9@archlinux>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0e37dbab-cb09-5920-5383-67e58cf290f6@redhat.com>
Date:   Sun, 2 Dec 2018 13:45:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181201162852.7007d1c9@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 01-12-18 17:28, Jonathan Cameron wrote:
> On Tue, 27 Nov 2018 14:54:15 +0800
> Daniel Drake <drake@endlessm.com> wrote:
> 
>> Hi,
>>
>> We are working with SMO8840 sensors integrated into several Acer
>> all-in-one consumer PCs and we would like to make the accelerometer
>> work with iio-sensor-proxy so that the display is auto-rotated based
>> on the physical orientation of the device.
>>
>> One option is to inspect each device and then apply a mount matrix
>> override in systemd, but we are looking for a generic solution. On
>> Windows 10 the same functionality "just works" with the standard
>> drivers from ST.
>>
>> Looking at the Windows 10 situation, I can see that the ACPI DSDT
>> includes orientation data for the accelerometer device, in a package
>> named _ONT. Using an in-memory DSDT override I was able to remove this
>> package in order to examine the "raw" uncorrected data from Windows.
>>
>> I could then deduce the meanings of the 6 values in _ONT: the first 3
>> are axis ordering, so the values "1 0 2" imply that the data arrives
>> in order of axis Y, X, Z, or in other words X and Y are swapped. The
>> final 3 values are inversion flags, values "0 0 1" mean that the Z
>> values must have their sign flipped.
> 
> Ouch, they could at least have done something that inherently maintained
> the handedness of the axes rather than doing it as a swap axis and
> separate correction for the handedness.
> 
> Or even, perhaps actually bothered to look at adding their _ONT
> mapping to the ACPI spec.  It would be a stretch for me to justify
> that one in the day job or I'd be tempted...  When will people learn
> that they shouldn't just make up acpi elements.  There are perfectly
> good ways  of adding manufacturer data.. *sigh*
> 
> Great digging by the way!  If others with ST sensors could dump their
> DSDT and use iASL to decompile it to see if they have an _ONT entry
> that would be great!

Great digging indeed, thanks Daniel.

Unfortunately it seems that the _ONT attribute is not universally
useful.

Out of the 75 DSTDs which I have an archive of (most of which are
2-in-1s or just tablets, so they have an accelerometer) only 3
actually have an _ONT method:

Generic 7 inch tablet from "GP-electronic":  using a KIOX000A accelerometer
MSI S100 tablet:                             using a SMO8500 accelerometer
Onda V975w tablet:                           using a SMO8500 accelerometer

But the 3 _ONT methods are all in (disabled _STA returns 0) SMO8821 nodes.

SMO8821 / SMO8840 are newer then the SMO8500, so perhaps that this _ONT
thing is something which we are going to see on more new devices with
ST / SMO sensors.

But I cannot help to confirm that the interpretation from this email thread
is correct.

Also this seems to be a ST / SMO sensor thing only.

Regards,

Hans




>> On this product the values are as above, 1 0 2 0 0 1 (swap X and Y,
>> negate Z). acpidump:
>> https://gist.github.com/dsd/588762aaa3b5601ff7fc6a8692755877
>>
>> However, looking to implement the same _ONT logic on Linux, I was met
>> with the surprise that the values read by st-accel-i2c do not match
>> the Windows values taken even when _ONT is removed.
>>
>> This is a "landscape-first" device like the one illustrated here:
>> https://blogs.windows.com/buildingapps/2015/09/03/new-sensor-features-in-windows-10/
>>
>> Here is the data. I took Windows measurements using the "Sensors" app
>> in the app store, and Linux measurements from sysfs in_accel_[xyz]_raw
>> and manually normalized into the range -1 to +1.
>>
>> 1. Placed flat on the desk, face up "looking up at the sky"
>> Windows (with _ONT): (0, 0, -1)
>> Windows (no _ONT): (0, 0, 1)
>> Linux: (0, 0, -1)
> 
> So their default is flip the z axis.
> 
>>
>> 2. Normal landscape orientation (i.e. picture the device positioned
>> the right way up and stuck to the wall)
>> Windows (with _ONT): (0, -1, 0)
>> Windows (no _ONT): (-1, 0, 0)
>> Linux: (0, 1, 0)
> 
> Then swap x and y (the flip is handedness correction in conjunction with the
> zaxis flip above.
> 
>>
>> 3. Rotated 90 degrees right from normal landscape orientation
>> Windows (with _ONT): (1, 0, 0)
>> Windows (no _ONT): (0, 1, 0)
>> Linux: (1, 0, 0)
> 
> And finally just swap x and y.
> 
>>
>> 4. Rotated 90 degrees left from normal landscape orientation
>> Windows (with _ONT): (-1, 0, 0)
>> Windows (no _ONT): (0, -1, 0)
>> Linux: (-1, 0, 0)
>>
>> 5. Rotated 180 degrees from normal landscape orientation (i.e. upside down)
>> Windows (with _ONT): (0, 1, 0)
>> Windows (no _ONT): (1, 0, 0)
>> Linux: (0, -1, 0)
>>
>> Why is the data read by Linux inconsistent with the data from Windows
>> even after I remove the _ONT orientation adjustment?
> 
> Given I'm fairly sure we basically just spit out the data directly
> from the sensor, the most likely explanation is that ST hard coded
> their driver to apply a transform for the first device they even
> mounted it in.  When another came along with it mounted differently
> they figured they needed to apply some sort of transform.
> 
> So their default is to first apply the following:
> 
> 1) Swap x and y,
> 2) Flip z and resulting x (which was y).
> 
> If we want to support their ONT we'll need to do this first, then
> apply ONT on top of that by forming the relevant mount matrix and
> outputting that to userspace.
> 
> If you fancy having a go it would be good to have this support!
> 
> Bastien / Hans if you could check my logic (as the two people who
> most often deal with this sort of horribleness!) that would be great.
> 
> Thanks,
> 
> Jonathan
> 
>>
>> Thanks
>> Daniel
> 
