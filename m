Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:57009 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbaJ1OYY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Oct 2014 10:24:24 -0400
Date: Tue, 28 Oct 2014 22:23:11 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	opw-kernel <opw-kernel@googlegroups.com>,
	linux-iio@vger.kernel.org
Subject: Re: [OPW kernel] [PATCH v3] staging: iio: iio_event_monitor: Add
 support for missing IIO modifiers
Message-ID: <20141028142311.GA18837@kroah.com>
References: <1413985817-10867-1-git-send-email-roberta.dobrescu@gmail.com>
 <CAEnQRZC2=1NaCfFjA6=TVU936LUzApobOgi5wPEOw6S4q3T29Q@mail.gmail.com>
 <544B73DD.2060802@kernel.org>
 <CAEnQRZABCT=+X1-gqZmyBBNECmA_cwUY0whZvf1Orob_8tnfEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAEnQRZABCT=+X1-gqZmyBBNECmA_cwUY0whZvf1Orob_8tnfEg@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Oct 28, 2014 at 02:40:21PM +0200, Daniel Baluta wrote:
> On Sat, Oct 25, 2014 at 12:56 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> > On 22/10/14 15:12, Daniel Baluta wrote:
> >> On Wed, Oct 22, 2014 at 4:50 PM, Roberta Dobrescu
> >> <roberta.dobrescu@gmail.com> wrote:
> >>> This patch adds the missing IIO modifiers in event_is_known function
> >>> and iio_modifier_names vector.
> >>>
> >>> Additionally, it removes duplicate name entries of IIO_MOD_LIGHT_BOTH
> >>> and IIO_MOD_LIGHT_IR in iio_modifier_names.
> >>>
> >>> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
> >>
> >> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
> >>
> > Applied to the togreg branch of iio.git - initially pushed out as
> > testing for the autobuilders to play.
> 
> Hi,
> 
> FYI:
> 
> Please note that this patch is both in Greg's staging-testing [1]
> and Jonathan's testing [2] tree.
> 
> thanks,
> Daniel.
> 
> [1] https://git.kernel.org/cgit/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=0a6e2170dfcd2b17ae32ad91993edf2b77014137
> [2] https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=a9bef750135cc261bfceff6840a30a3f357df8da

That's ok, git handles that just fine when we merge together.

greg k-h
