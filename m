Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60855 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966647Ab2EQP01 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 May 2012 11:26:27 -0400
Received: by pbbrp8 with SMTP id rp8so2662930pbb.19
        for <linux-iio@vger.kernel.org>; Thu, 17 May 2012 08:26:27 -0700 (PDT)
Date: Thu, 17 May 2012 08:26:18 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Subject: Re: iio, add support for HMC5883/HMC5883L to HMC5843 driver
Message-ID: <20120517152618.GA13735@kroah.com>
References: <1337214493-28773-1-git-send-email-pmeerw@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337214493-28773-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, May 17, 2012 at 02:28:07AM +0200, Peter Meerwald wrote:
> submitting the remaining HMC5843 patches to add HMC5883 support 
> to staging-next; I was a bit behind and missed commit 527cf71fd04e053983f97c98cf79c622d8d52db9 (Use dev_to_iio_dev())

Thanks, now applied.

greg k-h
