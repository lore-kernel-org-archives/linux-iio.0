Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-223.synserver.de ([212.40.185.223]:1032 "EHLO
	smtp-out-145.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754653AbaBTJEZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Feb 2014 04:04:25 -0500
Message-ID: <5305C527.5060800@metafoo.de>
Date: Thu, 20 Feb 2014 10:04:39 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [RFC]coding style for NULL pointer checks
References: <5300ACC6.90509@gmx.de> <530109DE.3010607@metafoo.de> <53031C67.8060202@kernel.org> <53053609.40806@gmx.de>
In-Reply-To: <53053609.40806@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/19/2014 11:54 PM, Hartmut Knaack wrote:
[...]
> Concerning the staging drivers, I miss some motivation to work on device drivers that I don't have the devices for. Therefor I was mainly focusing on the ad799x. So, by the way, which are currently the show-stoppers for the ad799x preventing a move out of staging?
[...]

No, that was the last blocker, I do have a patch that moves it out of 
staging, will submit it soon.

- Lars


