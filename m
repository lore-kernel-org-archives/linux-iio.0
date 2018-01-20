Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751324AbeATPTH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Jan 2018 10:19:07 -0500
Date: Sat, 20 Jan 2018 15:19:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFP] iio: Support of gesture sensor as a standard IIO sensor
Message-ID: <20180120151908.1d438aaf@archlinux>
In-Reply-To: <20180118224026.GE17196@amd>
References: <1515197240.26317.65.camel@intel.com>
        <20180118224026.GE17196@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 18 Jan 2018 23:40:26 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > From an IIO sensor point of view A Gesture sensor:
> > Outputs
> > 	A pre defined activity type
> > 		WAKE
> > 		TILT
> > 		GLANCE
> > 		PICK_UP
> > 		 &
> > 		 more
> > 
> > 	A user defined activity type as "string"  
> 
> Pre-defined activities are easy.
> 
> But what about user-defined activities? We'd really like common
> interface across different hardware... 

Nasty to handle indeed.   It may be the best we can do initially
at least is user_definedN or similar.  No way of constraining
users from uploading something really odd that we can't define
an interface for (hopping whilst holding a phone in
their teeth?)
> 
> > Inputs
> > 	A raw binary cdev interface to download templates/patterns  
> 
> ....and "raw binary" will not work across different hardware :-(.

Sadly there probably isn't much we can do about the format being custom.
Best bet would ultimately be if there was at least a standard tool
to generate the files for different devices...

> 
> 									Pavel

