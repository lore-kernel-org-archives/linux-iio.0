Return-Path: <SRS0=+BiV=RV=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609EEC4360F
	for <linux-iio@archiver.kernel.org>; Mon, 18 Mar 2019 09:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0748C214AF
	for <linux-iio@archiver.kernel.org>; Mon, 18 Mar 2019 09:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="lHKP33M9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfCRJck (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:32:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42143 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbfCRJcj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Mar 2019 05:32:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id r15so8103340pfn.9
        for <linux-iio@vger.kernel.org>; Mon, 18 Mar 2019 02:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k3NuoODZLzIJmCxwjRdOWSkfwi9xzMVPTPZZBQ/9F7k=;
        b=lHKP33M9NUR9zWc8lcPFXI+U7DCQxjpr8FISeHl5FCDSxKIG7W27JWjQ5WeAaSa5B9
         rZZdlKmvn9Q4xyma9Cz5GrxRz0F4KwRN8DEXwyekoMqhoZIZbusIr+Es1C+pflCAz5kS
         VcSi5Ftvue6N10I3Kbu7ZGCxdUK/2jVXNEtSpvoAwvWCcpuBI13GY38cI/nAkYtP3+Zi
         t657ominEcdfAGvi93H4xy6KFV8y3KqIYVyjW21C7yDEuSolrlIyBA4avTl2SDdUJhwO
         tybV8xKQCJUucLcmsIoOJQvpYrfeY2D0+1FQFd98XxCVyZtiX6Iteu/3+25BmoSr35Z1
         dOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=k3NuoODZLzIJmCxwjRdOWSkfwi9xzMVPTPZZBQ/9F7k=;
        b=aDf0iw8fIt2ZJ1ZH3uufsoeuvWAt7GDDJjDnY/RIpIpCNEQwlwLr8KeNytC2ZrRmUZ
         2pSq95rKPZflokrFiRISO3xsirRjPOpI6FY/mV8M99PDCHZWtEPT4CoxwWyl/5G+bn6k
         xyoqzaa8F6HBr2tApB67tqoA1w3NQ9B6pdSDrKeW7qscQI+c2FntPFhfsahGDiixY+9j
         bLOlmuTPgSDLx3f//mY3fef1Wk1HO+hIvSnx2AWdlHVKC1zCMMc9e2Wjgn2OeuB0lnH1
         QRXRhhVRn/30aZmUK1RpSXF0gIlx5vvByHLW2xyLHe7oLpgAmR19zUHpyOKFdoCkpS2T
         mGlQ==
X-Gm-Message-State: APjAAAU1/L9f0fzvaiU0UT0ecUWvA/3TVZNFl90lpwT1CZbAhBbhAdIh
        5O78PFSvAbd1PdI0ZGt9cLA+VA==
X-Google-Smtp-Source: APXvYqzwMERafDgH+CPryGHLgt0paO7VF8j9vAxPB919PgB/f+dy+LgBi2cU16i60DkZ8Sn3dnChIg==
X-Received: by 2002:a63:6193:: with SMTP id v141mr16721764pgb.392.1552901558292;
        Mon, 18 Mar 2019 02:32:38 -0700 (PDT)
Received: from [192.168.10.152] (124-171-140-5.dyn.iinet.net.au. [124.171.140.5])
        by smtp.gmail.com with ESMTPSA id h15sm10472473pgd.12.2019.03.18.02.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 02:32:37 -0700 (PDT)
Subject: Re: Debugging 3D sensor on Lenovo YOGA 700-11ISK
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "jic23@jic23.retrosnub.co.uk" <jic23@jic23.retrosnub.co.uk>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "hadess@hadess.net" <hadess@hadess.net>
References: <eb33acca-f48d-a689-c5e7-6f9b66f50caf@ozlabs.ru>
 <20190316183348.76573887@archlinux>
 <b6795bcb3d1c6e827c256e9c16f6e582b29358fc.camel@intel.com>
 <7552a684-90ea-2066-ef0b-4e25390b6d55@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <d5773e94-043a-2971-2c2e-2838b9105df2@ozlabs.ru>
Date:   Mon, 18 Mar 2019 20:32:33 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <7552a684-90ea-2066-ef0b-4e25390b6d55@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 18/03/2019 11:39, Alexey Kardashevskiy wrote:
> 
> 
> On 18/03/2019 03:39, Pandruvada, Srinivas wrote:
>> On Sat, 2019-03-16 at 18:33 +0000, Jonathan Cameron wrote:
>>> +CC bastien and (guessing it is a HID sensor) Srinivas.
>>> On Sat, 16 Mar 2019 20:16:39 +1100
>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>
>>>> Hi!
>>>>
>>>> I got a quite old Lenovo YOGA 700-11ISK with flip screen and run
>>>> fedora29 on it. I found that gnome3 cannot properly detect the
>>>> screen
>>>> orientation and the screen keeps rotating non stop.
>>>>
>>>> I opened an issue agains iio-sensor-proxy, not much luck there.
>>>> https://github.com/hadess/iio-sensor-proxy/issues/220
>>>>
>>>> I resumed my debugging and the situation seems improving.
>>>>
>>>> The yoga is running fedora29 v4.20.14. The fedora's iio-sensor-
>>>> proxy
>>>> still has this problem and so does the iio-sensor-proxy upstream
>>>> version.
>>>>
>>>> Then I commented out &iio_buffer_accel to make &iio_poll_accel work
>>>> -
>>>> and things worked nicely. I looked in sysfs and in_accel_?_raw seem
>>>> to
>>>> have correct values (same as in the first log below, give or take),
>>>> all
>>>> good. Recorded some debug from iio-sensor-proxy:
>>>>
>>>> Accel read from IIO on 'accel_3d': -39, -937, -378 (scale 0.009807)
>>>> Accel sent by driver (quirk applied): -39, -937, -378 (scale:
>>>> 0.009807)
>>>> Emitted orientation changed: from undefined to normal
>>>> No new data available on 'iio:device3'
>>>> Accel read from IIO on 'accel_3d': -39, -933, -371 (scale 0.009807)
>>>> Accel sent by driver (quirk applied): -39, -933, -371 (scale:
>>>> 0.009807)
>>>> No new data available on 'iio:device3'
>>>> Accel read from IIO on 'accel_3d': -39, -933, -367 (scale 0.009807)
>>>> Accel sent by driver (quirk applied): -39, -933, -367 (scale:
>>>> 0.009807)
>>>>
>>>> This is the good log, gnome works fine.
>>>>
>>>>
>>>> Then I recorded debug with the buffer driver enabled:
>>>>
>>>> rocess_scan_1: channel_index: 0, chan_name: in_accel_x,
>>>> channel_data_index: 0 location: 0
>>>> process_scan_1: channel_index: 1, chan_name: in_accel_y,
>>>> channel_data_index: 1 location: 4
>>>> process_scan_1: channel_index: 2, chan_name: in_accel_z,
>>>> channel_data_index: 2 location: 8
>>>> Accel read from IIO on 'iio:device4': -15, -898, -375 (scale
>>>> 0.009807)
>>>> Accel sent by driver (quirk applied): -15, -898, -375 (scale:
>>>> 0.009807)
>>>> Emitted orientation changed: from undefined to normal
>>>> No new data available on 'iio:device3'
>>>> process_scan_1: channel_index: 0, chan_name: in_accel_x,
>>>> channel_data_index: 0 location: 0
>>>> process_scan_1: channel_index: 1, chan_name: in_accel_y,
>>>> channel_data_index: 1 location: 4
>>>> process_scan_1: channel_index: 2, chan_name: in_accel_z,
>>>> channel_data_index: 2 location: 8
>>>> Accel read from IIO on 'iio:device4': 20774, 27203, 0 (scale
>>>> 0.009807)
>>>> Accel sent by driver (quirk applied): 20774, 27203, 0 (scale:
>>>> 0.009807)
>>>> Emitted orientation changed: from normal to left-up
>>>> No new data available on 'iio:device3'
>>>> process_scan_1: channel_index: 0, chan_name: in_accel_x,
>>>> channel_data_index: 0 location: 0
>>>> process_scan_1: channel_index: 1, chan_name: in_accel_y,
>>>> channel_data_index: 1 location: 4
>>>> process_scan_1: channel_index: 2, chan_name: in_accel_z,
>>>> channel_data_index: 2 location: 8
>>>> Accel read from IIO on 'iio:device4': -31, -929, -398 (scale
>>>> 0.009807)
>>>> Accel sent by driver (quirk applied): -31, -929, -398 (scale:
>>>> 0.009807)
>>>> Emitted orientation changed: from left-up to normal
>>>> No new data available on 'iio:device3'
>>>> process_scan_1: channel_index: 0, chan_name: in_accel_x,
>>>> channel_data_index: 0 location: 0
>>>> process_scan_1: channel_index: 1, chan_name: in_accel_y,
>>>> channel_data_index: 1 location: 4
>>>> process_scan_1: channel_index: 2, chan_name: in_accel_z,
>>>> channel_data_index: 2 location: 8
>>>> Accel read from IIO on 'iio:device4': -14345, -32024, 12738 (scale
>>>> 0.009807)
>>>> Accel sent by driver (quirk applied): -14345, -32024, 12738 (scale:
>>>> 0.009807)
>>>>
>>>> So it is good reading, bad reading, good reading, bad reading, and
>>>> gnome
>>>> rotates the screen non stop. No wonder gnome3 goes crazy.
>> I suppose you don't move the screen.
> 
> Correct.
> 
>> Try this to see if there is some
>> conversion errors in iio-sensor-proxy in some cases. Raw data is a
>> simply push from firmware, without any conversion..
> 
> Where does this push happen? Here?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/accel/hid-sensor-accel-3d.c#n244
> 
> 
>> rename /usr/sbin/iio-sensor-proxy for test only. Then reboot.
>> As part of linux kernel git, tools/iio, build iio-generic-buffer.
>>
>> #sudo ./iio_generic_buffer -l 1 -a -c 100 -n accel_3d'
> 
> 
> I'll give it a try tonight.


Tried. The laptop was on a desk, firmly fixed, the tool printed first 2
entries and stops, I had to tap slightly on the laptop to make it
continue. Tried a few times, first few readings, a pause, a tap,
continues. In the example below one reading is weird (usually more are
weird), others seem good.

[root@aikyoga aik]# ./iio_generic_buffer -l 1 -a -c 100 -n accel_3d
iio device number being used is 0
iio trigger number being used is 0
Enabling all channels
Enabling: in_accel_x_en
Enabling: in_accel_z_en
Enabling: in_timestamp_en
Enabling: in_accel_y_en
/sys/bus/iio/devices/iio:device0 accel_3d-dev0
-0.382459 -9.071151 -3.824593 1552900771368191813
-0.382459 -9.071151 -3.824593 1552900771376264500
-0.343233 -8.423912 -4.971972 1552900776231212060
0.000000 0.000000 0.000000 1552900776232597107
-0.343233 -8.384686 -4.971972 1552900776251252367
0.000000 0.000000 0.000000 1552900776252606419
-0.343233 -8.345459 -5.011198 1552900776271057304
0.000000 0.000000 0.000000 1552900776272409930
-0.264780 -8.306232 -5.089651 1552900776291133439
0.000000 0.000000 0.000000 1552900776292461896
-0.225553 -8.306232 -5.168105 1552900776311581316
225.484299 -153.042572 20.466478 1552900776312958364
-0.225553 -8.306232 -5.168105 1552900776331232430
0.000000 0.000000 0.000000 1552900776332459423
-0.225553 -8.267006 -5.128878 1552900776351265820
0.000000 0.000000 0.000000 1552900776352593055
-0.264780 -8.267006 -5.168105 1552900776371443772
0.000000 0.000000 0.000000 1552900776372784463
-0.264780 -8.267006 -5.246558 1552900776391549343
0.000000 0.000000 0.000000 1552900776392968369
-0.225553 -8.306232 -5.315204 1552900776411677753
0.000000 0.000000 0.000000 1552900776412998853
-0.225553 -8.306232 -5.285784 1552900776431528699
0.000000 0.000000 0.000000 1552900776432881821
-0.225553 -8.306232 -5.207331 1552900776451678405
0.000000 0.000000 0.000000 1552900776452999756
-0.264780 -8.306232 -5.168105 1552900776471988891
0.000000 0.000000 0.000000 1552900776473335616
-0.264780 -8.306232 -5.168105 1552900776491891346
0.000000 0.000000 0.000000 1552900776493215237
-0.264780 -8.306232 -5.207331 1552900776516048625
0.000000 0.000000 0.000000 1552900776517478859
-0.264780 -8.306232 -5.207331 1552900776535855901
0.000000 0.000000 0.000000 1552900776537239117
-0.264780 -8.306232 -5.207331 1552900776556004660
0.000000 0.000000 0.000000 1552900776557361617
-0.264780 -8.306232 -5.168105 1552900776575969969
0.000000 0.000000 0.000000 1552900776577367957
-0.264780 -8.306232 -5.168105 1552900776596219505
0.000000 0.000000 0.000000 1552900776597645139
-0.304006 -8.306232 -5.168105 1552900776616188646
0.000000 0.000000 0.000000 1552900776617519289
-0.304006 -8.306232 -5.168105 1552900776636243776
0.000000 0.000000 0.000000 1552900776637629204
-0.264780 -8.306232 -5.207331 1552900776656315247
0.000000 0.000000 0.000000 1552900776657662508
-0.264780 -8.306232 -5.246558 1552900776676430435
0.000000 0.000000 0.000000 1552900776677854697
-0.225553 -8.306232 -5.246558 1552900776696561899
0.000000 0.000000 0.000000 1552900776697953993
-0.225553 -8.306232 -5.246558 1552900776716687038
0.000000 0.000000 0.000000 1552900776718013507
-0.225553 -8.306232 -5.207331 1552900776736600192
0.000000 0.000000 0.000000 1552900776737979245
-0.264780 -8.306232 -5.207331 1552900776756661393
0.000000 0.000000 0.000000 1552900776757973656
-0.264780 -8.345459 -5.168105 1552900776776918044
0.000000 0.000000 0.000000 1552900776778285204
-0.304006 -8.345459 -5.168105 1552900776796719607
0.000000 0.000000 0.000000 1552900776798043915
-0.304006 -8.345459 -5.168105 1552900776816969788
0.000000 0.000000 0.000000 1552900776818346899
-0.304006 -8.345459 -5.168105 1552900776836866458
0.000000 0.000000 0.000000 1552900776838190275
-0.264780 -8.306232 -5.207331 1552900776857025283
0.000000 0.000000 0.000000 1552900776858365006
-0.225553 -8.306232 -5.246558 1552900776876999835
0.000000 0.000000 0.000000 1552900776878320702
-0.225553 -8.306232 -5.246558 1552900776897067887
0.000000 0.000000 0.000000 1552900776898409864
-0.264780 -8.306232 -5.246558 1552900776917154306
0.000000 0.000000 0.000000 1552900776918528686
-0.264780 -8.306232 -5.207331 1552900776937174085
0.000000 0.000000 0.000000 1552900776938501132
-0.264780 -8.345459 -5.168105 1552900776957203402
0.000000 0.000000 0.000000 1552900776958540063
-0.264780 -8.345459 -5.168105 1552900776977338314
0.000000 0.000000 0.000000 1552900776978682085
-0.264780 -8.345459 -5.168105 1552900776997480789
0.000000 0.000000 0.000000 1552900776998808922
-0.264780 -8.306232 -5.168105 1552900777017397456
0.000000 0.000000 0.000000 1552900777018741222
-0.264780 -8.306232 -5.207331 1552900777037476271
0.000000 0.000000 0.000000 1552900777038806156
-0.264780 -8.306232 -5.207331 1552900777057563044
0.000000 0.000000 0.000000 1552900777058959603
-0.264780 -8.306232 -5.207331 1552900777077670982
0.000000 0.000000 0.000000 1552900777078985450
-0.264780 -8.306232 -5.207331 1552900777097699720
0.000000 0.000000 0.000000 1552900777099120245
-0.264780 -8.306232 -5.168105 1552900777117694705
0.000000 0.000000 0.000000 1552900777119056044
-0.264780 -8.306232 -5.168105 1552900777137793443
0.000000 0.000000 0.000000 1552900777139114214
-0.264780 -8.306232 -5.168105 1552900777158067260
0.000000 0.000000 0.000000 1552900777159426560
-0.264780 -8.306232 -5.207331 1552900777177946936
0.000000 0.000000 0.000000 1552900777179274696
-0.264780 -8.306232 -5.207331 1552900777198216778
0.000000 0.000000 0.000000 1552900777199587760
Disabling: in_accel_x_en
Disabling: in_accel_z_en
Disabling: in_timestamp_en
Disabling: in_accel_y_en
[root@aikyoga aik]#


But then I did more experimenting. I put laptop on my laps (so it was
not firmly fixed but I did not move it or rotate it) and started the
tool again. I got quite inconsistent readings:

-0.186326 -8.463139 -4.971972 1552900984763903094
-141.853195 -235.241913 251.001205 1552900984765201219
-0.186326 -8.423912 -4.824872 1552900984783855026
172.204773 249.824402 -219.482635 1552900984785172204
-0.147100 -8.423912 -4.628739 1552900984803895624
-219.482635 186.777451 -235.241913 1552900984805211796
-0.029420 -8.463139 -4.403186 1552900984823989997
0.000000 -32.705177 -235.241913 1552900984825302896
0.107873 -8.502365 -4.285506 1552900984843951448
0.000000 -32.705177 -235.241913 1552900984845283264
0.186326 -8.541592 -4.442412 1552900984864076546
251.001205 -173.381561 187.964050 1552900984865409126


And then I run it as "./iio_generic_buffer -l 1 -a -c 10000 -n accel_3d"
(10000 vs 100) and I got 10000 of very consistent readings like this:

-0.068647 -8.463139 -4.785645 1552900954123256005
-0.068647 -8.463139 -4.785645 1552900954124609317
0.000000 -8.502365 -5.050425 1552900954223793352
0.000000 -8.502365 -5.050425 1552900954225123224
0.107873 -8.463139 -4.824872 1552900954504475745
0.107873 -8.463139 -4.824872 1552900954505898733
-0.147100 -8.463139 -4.824872 1552900954564807056


I tried bisecting the number but around 3900..4000 it simply gave up :)

[  539.215108] i2c_designware i2c_designware.0: controller timed out
[  539.240414] i2c_designware i2c_designware.0: timeout in disabling adapter
[  539.263406] i2c_designware i2c_designware.0: timeout waiting for bus
ready
[  539.263410] i2c_hid i2c-ITE8350:00: failed to set a report to device.
[  539.285978] i2c_designware i2c_designware.0: timeout waiting for bus
ready


Looks like a weird accident though.


> 
> 
>>
>>
>> Thanks,
>> Srinivas
>>
>>>>
>>>> I would debug further and even come up with a fix but I failed to
>>>> find
>>>> quickly where there reads are handled in the kernel, and what
>>>> defines
>>>> these in_accel_?_raw files in sysfs, tried grepping - nothing. Any
>>>> pointers?
>>
>>
>>>
>>> The raw files are built by the IIO core to call the read_raw callback
>>> in the
>>> each driver.  The path for buffered data is very different.
>>> Ultimately
>>> it goes through a call to iio_push_to_buffers.
>>>
>>>>
>>>>
>>>> Also, how do I identify my particular 3d sensor? Or it is the same
>>>> model
>>>> everywhere? Or it is the driver for all of them?
>>>
>>> Lots an lots and lots of drivers ;)   But in laptops they are often
>>> hid-sensors, or at least there is a little microcontroller that
>>> handles
>>> the different streams and reformats them as hid sensor records.
>>>
>>>>
>>>> Here is dmesg | grep i2c:
>>>
>>> First of all, let us check the device. I'm going to guess it's a hid
>>> sensor of some type.
>>> Could you cat
>>> /sys/bus/iio/devices/iio\:device0/name
>>>
>>> When iio-sensor-proxy is running (or after you've killed it) check
>>> what the values in the various files in
>>> /sys/bus/iio/devices/iio\:device0/scan_elements/* 
>>> are.  One thought is we have some unexpected channels enabled and
>>> the code is thinking they are acceleration when they aren't.
>>>
>>>>
>>>> [root@aikyoga iio:device4]# dmesg | egrep '(i2c|iio)'
>>>> [    5.389867] i2c_hid i2c-ITE8350:00: i2c-ITE8350:00 supply vdd
>>>> not
>>>> found, using dummy regulator
>>>> [    5.389893] i2c_hid i2c-ITE8350:00: Linked as a consumer to
>>>> regulator.0
>>>> [    5.389896] i2c_hid i2c-ITE8350:00: i2c-ITE8350:00 supply vddl
>>>> not
>>>> found, using dummy regulator
>>>> [    5.502896] hid-generic 0018:048D:8350.0002: hidraw1: I2C HID
>>>> v1.00
>>>> Device [ITE8350:00 048D:8350] on i2c-ITE8350:00
>>>> [    5.528455] i2c_hid i2c-SYNA2B23:00: i2c-SYNA2B23:00 supply vdd
>>>> not
>>>> found, using dummy regulator
>>>> [    5.528485] i2c_hid i2c-SYNA2B23:00: Linked as a consumer to
>>>> regulator.0
>>>> [    5.528489] i2c_hid i2c-SYNA2B23:00: i2c-SYNA2B23:00 supply vddl
>>>> not
>>>> found, using dummy regulator
>>>> [    5.543440] input: SYNA2B23:00 06CB:2714 Mouse as
>>>> /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-6/i2c-
>>>> SYNA2B23:00/0018:06CB:2714.0003/input/input13
>>>> [    5.543690] hid-generic 0018:06CB:2714.0003: input,hidraw2: I2C
>>>> HID
>>>> v1.00 Mouse [SYNA2B23:00 06CB:2714] on i2c-SYNA2B23:00
>>>> [    6.053237] input: Synaptics TM2714-002 as
>>>> /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-6/i2c-
>>>> SYNA2B23:00/0018:06CB:2714.0003/input/input16
>>>> [    6.053444] hid-rmi 0018:06CB:2714.0003: input,hidraw1: I2C HID
>>>> v1.00
>>>> Mouse [SYNA2B23:00 06CB:2714] on i2c-SYNA2B23:00
>>>>
>>>> Thanks!
>>>>
>>>>
>>>
>>>
> 

-- 
Alexey
