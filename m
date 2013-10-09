Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42486 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752860Ab3JID47 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 8 Oct 2013 23:56:59 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-iio@m.gmane.org>)
	id 1VTktI-0008IT-6z
	for linux-iio@vger.kernel.org; Wed, 09 Oct 2013 05:56:55 +0200
Received: from 202.153.39.235 ([202.153.39.235])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Wed, 09 Oct 2013 05:56:52 +0200
Received: from chskr1016 by 202.153.39.235 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Wed, 09 Oct 2013 05:56:52 +0200
To: linux-iio@vger.kernel.org
From: crzy <chskr1016@gmail.com>
Subject: Re: change device attributes dynamically
Date: Wed, 9 Oct 2013 03:56:30 +0000 (UTC)
Message-ID: <loom.20131009T055541-305@post.gmane.org>
References: <loom.20131008T094235-776@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

crzy <chskr1016@...> writes:

> 
> I want to change device attributes at /sys/iio..... for AD-FMCOMMS1-
EBZ.When 
> will the driver detects the value is changed?will the driver dynamically 
> detects them ?
> i want to change values dynamically like
> echo 500000000 > out_altvoltage1_DAC_CLK_frequency
> 
> 


when will the device reads register value? i mean when will device changes 
its clk frequency?
Plz tell me how this process takes place

