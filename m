Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:58481 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbaHKMQz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 11 Aug 2014 08:16:55 -0400
Received: by mail-vc0-f180.google.com with SMTP id ij19so11439159vcb.11
        for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2014 05:16:54 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 11 Aug 2014 15:16:54 +0300
Message-ID: <CAN0s7yTK1_1u65nodysfiGxYbgKTeDS0Vf_+14KQJS92_Di1vg@mail.gmail.com>
Subject: Resource Temporarily Unavailable error when trying to read from the
 accelerator on a ThinkPad twist
From: Elad Alfassa <elad@fedoraproject.org>
To: linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi.

I have a Thinkpad Twist, this is a Windows 8 certified machine from
around 2012, and it has an accelerometer.
Running kernel 3.16.0-1.fc22.x86_64, I'm getting "Resource Temporarily
Unavailable" when trying to read from the accelerometer.

Tiny bit more details:
https://github.com/hadess/iio-sensor-proxy/issues/1
https://sysdev.microsoft.com/en-us/hardware/LPL/ProductDetails.aspx?ProductID=98463&OrganizationID=4733

Is this a known issue? Can I help debug this in any way?


Thanks.

-- 
-Elad Alfassa.
