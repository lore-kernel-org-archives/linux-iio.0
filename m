Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53564 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756173AbbDIQKc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2015 12:10:32 -0400
Message-ID: <5526A476.7010205@kernel.org>
Date: Thu, 09 Apr 2015 17:10:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	"Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>
CC: "knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: light: ltr501: Fix alignment to match open parenthesis
References: <1428589067-3582-1-git-send-email-daniel.baluta@intel.com> <EF0FAAD101DE534CAD726F2BFBA868D34264B683@ORSMSX113.amr.corp.intel.com> <55269450.9000908@intel.com>
In-Reply-To: <55269450.9000908@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/04/15 16:01, Daniel Baluta wrote:
> 
> 
> On 04/09/2015 05:51 PM, Kuppuswamy, Sathyanarayanan wrote:
>> Hi Daniel,
>>
>> You have asked me to include this patch in my LTR501 patch set. I have already sent few versions of my patch set with your patch. Do you want to submit it again separately?
> 
> Hi Sathya,
> 
> After Jonathan's comments on patch series titled:
> "[PATCH v3 0/6] Added LTR501 Interrupt support"
> 
> you will still need to send another version.
> 
> I think the best way to synchronize on this is for Jonathan to take this current patch as I've rebased it on the tip of iio/testing.
Yup, I've just applied this one as well to the same branch.

Sorry, wasn't being that observant earlier and didn't register this one was in the other series as well.

Jonathan
> 
> thanks,
> Daniel.

