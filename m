Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:35617 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780AbaDLTyt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Apr 2014 15:54:49 -0400
Date: Sat, 12 Apr 2014 12:57:41 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v3 1/6] devres: introduce API "devm_kmemdup
Message-ID: <20140412195741.GA10564@kroah.com>
References: <1397004988-31550-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <53496C49.9070900@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53496C49.9070900@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Apr 12, 2014 at 05:39:37PM +0100, Jonathan Cameron wrote:
> On 09/04/14 01:56, Srinivas Pandruvada wrote:
> > Introduce devm_kmemdup, which uses resource managed kmalloc.
> > There are several request from maintainers to add this instead
> > of using kmemdup.
> >
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> I've been trying to work out who else should be cc'd on this and
> so far I've come up with Greg...

Yes, I take these types of patches, just bundle it with your iio
patches that take advantage of this.

