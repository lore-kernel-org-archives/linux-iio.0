Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:35548 "EHLO
	anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753612AbbLPD6U (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Dec 2015 22:58:20 -0500
To: linux-iio@vger.kernel.org
From: Phil Reid <preid@electromag.com.au>
Subject: IIO and high speed
Message-ID: <5670E151.7000909@electromag.com.au>
Date: Wed, 16 Dec 2015 11:58:09 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

G'day All,

I'm just enquiring what the status / plans are for the IIO high speed interface.

This code is present in libiio to do zero copy operations using IIO_BLOCK* ioctls.
EG: I get a warning when running iio_readdev about high speed not being enabled.

However corresponding code is not in the mainline kernel, I did find something at:
https://github.com/analogdevicesinc/linux.git

Or has this line of development been discontinued in favour of another plan.
It looks to be a few years old.


-- 
Regards
Phil Reid
