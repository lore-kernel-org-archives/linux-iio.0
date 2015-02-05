Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:44045 "EHLO extserv.mm-sol.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067AbbBEMXQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 5 Feb 2015 07:23:16 -0500
Message-ID: <1423138991.6471.9.camel@mm-sol.com>
Subject: Re: [PATCH 2/3] iio: qcom-spmi-iadc: cleanup wait_for_completion
 return handling
From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nicholas Mc Guire <hofrat@osadl.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Thu, 05 Feb 2015 14:23:11 +0200
In-Reply-To: <54D24FDE.7000908@kernel.org>
References: <1422866227-10484-1-git-send-email-hofrat@osadl.org>
	 <54D24FDE.7000908@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On Wed, 2015-02-04 at 16:59 +0000, Jonathan Cameron wrote:
> On 02/02/15 08:37, Nicholas Mc Guire wrote:
> > This patch fixes two issues:
> > * return type of wait_for_completion_timeout is unsigned long not int,
> >   rather than adding a dedicated variable the wait_for_completion_timeout
> >   is moved into the condition directly
> > * the timeout of wait_for_completion_timeout is in jiffies but the value
> >   being passed was a unsigned long not converted to jiffies and thus was
> >   dependent on the HZ settings which is probably not what you want.
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Ivan, need your Ack / Reviewed-by on this one.
> 

Yes, change is correct, as explained before [1].

Acked-by: Ivan T. Ivanov <iivanov@mm-sol.com>


[1] https://lkml.org/lkml/2015/1/5/409

