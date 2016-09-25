Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:52556 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754801AbcIYSPS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Sep 2016 14:15:18 -0400
Date: Sun, 25 Sep 2016 19:15:09 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: iio: Adjust checks for null pointers in six functions
Message-ID: <20160925181509.GC19539@ZenIV.linux.org.uk>
References: <566ABCD9.1060404@users.sourceforge.net>
 <c11fbb47-1fd3-4e9e-042e-0f271cfef814@users.sourceforge.net>
 <8e0c9fdd-fc9a-0093-278f-00f3beb2a8f6@users.sourceforge.net>
 <5064024e-3510-cec9-d925-b617f7204579@kernel.org>
 <4e79ad49-17fc-1ab9-6a88-06cff959b6de@users.sourceforge.net>
 <e107c883-eff6-2002-46ba-05e691e142d1@kernel.org>
 <3b681d28-c3f9-7d54-f3f3-eccb51479356@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3b681d28-c3f9-7d54-f3f3-eccb51479356@users.sourceforge.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Sep 25, 2016 at 07:45:40PM +0200, SF Markus Elfring wrote:

> I assume that the involved software developers got a specific impression
> about the discussed patch series for this software module so that a few
> relevant dependencies became clearer eventually.
> 
> I proposed some update steps where I chose a specific patch granularity
> once more. So I imagine that a bit of variation in the patch order
> could be supported already.
> 
> Will it be possible to apply also this one a bit later just because
> the patch hunk contexts might be still valid in the (near) future?

I wonder if you realize that your postings _reek_ with the Strong Programme
intellectual offal...  Are you, by any chance, some kind of sociology grad?
You can't study development purely on the process level, ignoring the actual
usefulness of contributions and the fact that there are objective criteria
of their worth.
