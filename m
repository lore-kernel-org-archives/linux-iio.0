Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.206]:45821 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752789AbcK3R7L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Nov 2016 12:59:11 -0500
Date: Wed, 30 Nov 2016 18:59:36 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Akshay Vijapur <akshayvijapur@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: Ad5064 SPI probe not called
Message-ID: <20161130175936.GB28293@x220.localdomain>
References: <CAGQj8EDnMbsai9DwoQy+vMcuCv9es1f1+KKG3+h-W-AYjZtNhw@mail.gmail.com>
 <20161130123138.GA28293@x220.localdomain>
 <CAGQj8EA-wGpTStXMMjd=z+0Gssu0A4KgL1LAHaQ6OtQ9fPLzrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGQj8EA-wGpTStXMMjd=z+0Gssu0A4KgL1LAHaQ6OtQ9fPLzrw@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Nov 30, 2016 19:23, Akshay Vijapur wrote:
> But sir i  want to enable the ad5604 Digital to analog sensor , where
> to add the sensor information

>From what I can see this driver is not device tree friendly, so you would not be
able to load it using dt overlay.

As I understand you will have to change the board description c file for rpi3.
But this file does not exist for rpi3. So changing the driver to use device tree
is the only option here as far as I know...

-- 
Slawomir Stepien
