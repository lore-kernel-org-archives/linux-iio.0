Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42152 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab1CDH0r (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 4 Mar 2011 02:26:47 -0500
Received: by pvg12 with SMTP id 12so292518pvg.19
        for <linux-iio@vger.kernel.org>; Thu, 03 Mar 2011 23:26:47 -0800 (PST)
Message-ID: <4D709432.90003@gmail.com>
Date: Fri, 04 Mar 2011 15:26:42 +0800
From: Marten Svanfeldt <marten.svanfeldt@gmail.com>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: High frequency software trigger
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I have recently begun looking at utilizing iio for the input part of a 
robotics system but have some doubts about its usability for which I 
would like your comments.

Today we have (in our embedded system) a number of custom written 
drivers interfacing SPI attached accelerometers and AD converters, 
utilizing hrtimers for software triggering of sampling at 50 to 250 Hz. 
Herein lays my current question, has anyone used the IIO system with 
these type of sampling rates? The RTC based trigger seems to only give 
second or higher intervals.

I will be looking at converting our special drivers to be acceptable for 
upstream submission, same for a hrtimers based trigger, should that be a 
good idea.

Best regards
Marten Svanfeldt
