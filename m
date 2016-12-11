Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54021 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752898AbcLKPCk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Dec 2016 10:02:40 -0500
Subject: Re: Presenting duplicate channels for hid sensor light
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
References: <1481431720.3681.1.camel@intel.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3d5cb3c8-7931-b98a-185e-a06ce238ed7d@kernel.org>
Date: Sun, 11 Dec 2016 15:02:36 +0000
MIME-Version: 1.0
In-Reply-To: <1481431720.3681.1.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/12/16 04:48, Pandruvada, Srinivas wrote:
> Hi Jonathan,
> 
> HID sensor defines common illuminance field which can be output from
> light sensor and color sensors. Currently we are presenting this as
> intensity.
> There are some user spaces expecting only illuminance attribute for
> reading this and getting request to add this. 
> The only option I see is to add a duplicate channel.
> 
> What do you think?
Hi Srinivas,

This isn't the first time we have run into this sort of issue.

As you say, presenting a duplicate channel is pretty much the only option as we can't break
userspace by removing the old one.

As long as it is actually in the right units etc for illuminance, feel free to add the
channel.  If things get 'interesting' for buffered output it may be necessary to
only have one of them available via that interface.  Obviously this could be worked around
but it is probably more trouble that it is worth to do so!

Jonathan

>  
> 
> Thanks,
> SrinivasN�����r��y���b�X��ǧv�^�)޺{.n�+����{��*"��^n�r���z���h����&���G���h�(�階�ݢj"���m�����z�ޖ���f���h���~�mml==
> 

