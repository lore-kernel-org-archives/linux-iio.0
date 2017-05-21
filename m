Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33757 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756623AbdEUQG3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 May 2017 12:06:29 -0400
Received: by mail-lf0-f65.google.com with SMTP id m18so3415859lfj.0
        for <linux-iio@vger.kernel.org>; Sun, 21 May 2017 09:06:29 -0700 (PDT)
Subject: Re: Accelometer data not changes
From: Arek Burdach <arek.burdach@gmail.com>
To: lorenzo.pieralisi@arm.com
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>,
        srinivas.pandruvada@intel.com, linux-iio@vger.kernel.org,
        ard.biesheuvel@linaro.org, jarkko.nikula@linux.intel.com,
        wsa@the-dreams.de
References: <b9234130-1af6-738f-a174-379d441caedf@gmail.com>
Message-ID: <eb2166ea-ba3a-635c-49bc-583ebc9cb4dd@gmail.com>
Date: Sun, 21 May 2017 18:06:25 +0200
MIME-Version: 1.0
In-Reply-To: <b9234130-1af6-738f-a174-379d441caedf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Lorenzo,

I wanted to check if your newest fix 
9d6408433019bfae15e2d0d5f4498c4ff70b86c0 resolved my problem but it 
looks like it breaks i2c devices on yoga 910 at all.

One thing that I see in dmesg is:
[    5.443582] i2c_designware i2c_designware.1: controller timed out
[    5.443601] i2c_hid i2c-SYNA2B31:00: hid_descr_cmd failed
[    6.595650] i2c_designware i2c_designware.2: controller timed out
[    6.595673] i2c_hid i2c-ITE8186:00: hid_descr_cmd failed

More details you can see in mentioned isssue.
BTW maybe you have an idea what is the root of my problem. I've attached 
i2c_hid logs for previous version.

Cheers,
Arek

On 15.05.2017 23:39, Arek Burdach wrote:
> Hi,
>
> I'm trying to investigate bug reported here: 
> https://bugzilla.kernel.org/show_bug.cgi?id=195681
>
> I was trying to add similar quirk configuration like for Lenovo Yoga 
> 900 but it seems that didn't helped. Driver mostly not changing raw 
> data. I have a situation that it started to changing data, but I can't 
> reproduce it (possibly lsiio execution triggered it)
>
> I found out that there is many similar problems reported on 
> iio-sensor-proxy project:
> https://github.com/hadess/iio-sensor-proxy/issues?utf8=%E2%9C%93&q=is%3Aissue%20label%3A%22driver%20bug%22%20 
>
> , so it look like it is more generic problem.
>
> Can anyone confirm that accelometer works on yoga900/910 in any kernel 
> version?
>
> Can somebody help me, how to debug this problem?
>
> Cheers,
> Arek

