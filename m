Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51772 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933789AbbDIL4W (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2015 07:56:22 -0400
Message-ID: <552668EA.3060409@kernel.org>
Date: Thu, 09 Apr 2015 12:56:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Vlad Dogaru <vlad.dogaru@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH] iio: pressure: bmp280: fix temp compensation
References: <1428506772-23710-1-git-send-email-irina.tirdea@intel.com> <20150408153034.GA23781@vdogaru>
In-Reply-To: <20150408153034.GA23781@vdogaru>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/04/15 16:30, Vlad Dogaru wrote:
> On Wed, Apr 08, 2015 at 06:26:12PM +0300, Irina Tirdea wrote:
>> Temperature reads on bmp280 device always return 0,
>> due to a missing step in the compensation formula
>> (data->tfine is never initialized).
>>
>> Initialize data->tfine value so we get correct
>> temperature and pressure values.
>>
>> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> 
> Reviewed-by: Vlad Dogaru <vlad.dogaru@intel.com>
> 
> Nice catch, this must have been lost during a refactoring.
> 
> Thanks,
> Vlad
> 
Thanks,

Applied to fixes-togreg which is now based on staging-next
which gives you an idea of when this will go to Greg now!
