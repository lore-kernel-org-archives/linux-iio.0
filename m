Return-Path: <SRS0=ICcr=HO=metafoo.de=lars@kernel.org>
Subject: Re: Patch process question
To: Martin Kelly <mkelly@xevo.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
References: <80821ad8-08fe-2a2a-ea2d-08db094dcf4b@xevo.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <0d12f947-30be-6289-776b-f9dd22e04766@metafoo.de>
Date: Wed, 25 Apr 2018 20:09:56 +0200
MIME-Version: 1.0
In-Reply-To: <80821ad8-08fe-2a2a-ea2d-08db094dcf4b@xevo.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 04/25/2018 07:49 PM, Martin Kelly wrote:
> Hi,
> 
> I have a quick question regarding the patch submission process for IIO.
> Let's say I have a patch that I know will hit conflicts against other
> accepted patches that are in linux-iio testing and/or togreg but have
> not yet landed in torvalds master.
> 
> Which of these things should I do?
> 
> - Make patch against torvalds master (then it will have merge conflicts
> when accepted).
> 
> - Make patch against testing or togreg (whichever branch contains the
> conflicts).

Either this...

> - Wait to test/send the patch until the patches with conflicts make it
> into torvalds master (this could be a while, and depending on which
> patches get accepted, more conflicts may arise again in testing/togreg).

or this.
