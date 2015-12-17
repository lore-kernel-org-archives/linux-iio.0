Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:33331 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754824AbbLQUcx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 Dec 2015 15:32:53 -0500
Received: by mail-qg0-f45.google.com with SMTP id k90so38050416qge.0
        for <linux-iio@vger.kernel.org>; Thu, 17 Dec 2015 12:32:52 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 17 Dec 2015 21:32:52 +0100
Message-ID: <CABFtUbQw0nH5LXf_+D5_mSBqEdAsKEbbLCmrD=VDfgosqcWq1w@mail.gmail.com>
Subject: Correctness of acpi-als channel mask
From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I have a question regarding the acpi-als driver.

Currently acpi-als uses IIO_CHAN_INFO_RAW to report the data coming
from the sensor. However, as per the ACPI specification [1] (section
9.2.2), these values represent the ambient light illuminance expressed
in lux. Wouldn't IIO_CHAN_INFO_PROCESSED be more appropriate in this
case as the data are in theory pre-processed by the firmware of the
platform?

[1] http://www.acpi.info/DOWNLOADS/ACPIspec50.pdf

Regards,
Gabriele
