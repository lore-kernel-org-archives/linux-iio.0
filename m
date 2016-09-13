Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47841 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbcIMRuL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Sep 2016 13:50:11 -0400
Subject: Re: possible odd acceleration scaling
To: rrs@researchut.com, linux-iio@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Bastien Nocera <hadess@hadess.net>
References: <1473787814.8047.8.camel@researchut.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a9078c9f-0d07-35bc-e449-2cfeee7b7987@kernel.org>
Date: Tue, 13 Sep 2016 18:50:08 +0100
MIME-Version: 1.0
In-Reply-To: <1473787814.8047.8.camel@researchut.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/09/16 18:30, Ritesh Raj Sarraf wrote:
> Hello Srinivas and Others,
> 
> [Please CC me in replies. I'm not subscribed to the list]
> 
> This email is in regard to an odd behavior, we seems to have discovered with
> iio-sensor-proxy version 1.2 and the iio driver in Linux, maybe particular to
> the following driver.
> 
> 
> rrs@learner:~$ lsusb 
> Bus 003 Device 002: ID 8087:8000 Intel Corp. 
> Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 001 Device 006: ID 048d:8350 Integrated Technology Express, Inc. 
> Bus 001 Device 005: ID 0bda:b728 Realtek Semiconductor Corp. 
> Bus 001 Device 004: ID 04f2:b40f Chicony Electronics Co., Ltd 
> Bus 001 Device 003: ID 04f3:0303 Elan Microelectronics Corp. 
> Bus 001 Device 002: ID 0bda:0129 Realtek Semiconductor Corp. RTS5129 Card Reader
> Controller
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> 2016-09-13 / 22:56:58 ♒♒♒  ☺  
> 
> 
> rrs@learner:/sys/devices/pci0000:00/0000:00:14.0/usb1/1-8/1-
> 8:1.0/0003:048D:8350.0002/HID-SENSOR-200073.4.auto$ find iio\:device2/ -iname
> "*scale*" -print -exec cat '{}' \;
> iio:device2/in_accel_scale
> 0.009806
Looking at your bug report, raw readings are around magnitude 1000.
1000*0.009806 = 9.81

Given accelerations in IIO are in m/s^2 I'm slightly confused...

Guessing the iio-sensor-proxy might be getting it's idea of what counts
as orientation from the wrong place?  

I couldn't immediately see where it figures that out...

Jonathan

> 2016-09-13 / 22:37:29 ♒♒♒  ☺  
> 
> 
> Machine: Lenovo Yoga 2 13.
> 
> 
> For a background, please have a look at the github bug report.
> https://github.com/hadess/iio-sensor-proxy/issues/100
> 
> 
> If you need any information, please let me know. I'm not sure what other
> information to provide upfront, that maybe be relevant.
> 
> 
> 
