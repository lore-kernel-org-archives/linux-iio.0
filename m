Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:60988 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755713AbcIYRqA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Sep 2016 13:46:00 -0400
Subject: Re: iio: Adjust checks for null pointers in six functions
To: Jonathan Cameron <jic23@kernel.org>
References: <566ABCD9.1060404@users.sourceforge.net>
 <c11fbb47-1fd3-4e9e-042e-0f271cfef814@users.sourceforge.net>
 <8e0c9fdd-fc9a-0093-278f-00f3beb2a8f6@users.sourceforge.net>
 <5064024e-3510-cec9-d925-b617f7204579@kernel.org>
 <4e79ad49-17fc-1ab9-6a88-06cff959b6de@users.sourceforge.net>
 <e107c883-eff6-2002-46ba-05e691e142d1@kernel.org>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <3b681d28-c3f9-7d54-f3f3-eccb51479356@users.sourceforge.net>
Date: Sun, 25 Sep 2016 19:45:40 +0200
MIME-Version: 1.0
In-Reply-To: <e107c883-eff6-2002-46ba-05e691e142d1@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> Also, I'm afraid I don't care enough to put the time in for this one.

It's a pity.


>> Does the tool "Git" let you also apply this update step before
>> the other suggestions?
> It rarely copes with this sort of reordering as it doesn't have
> the semantic knowledge of what matters in the other patches.

I assume that the involved software developers got a specific impression
about the discussed patch series for this software module so that a few
relevant dependencies became clearer eventually.

I proposed some update steps where I chose a specific patch granularity
once more. So I imagine that a bit of variation in the patch order
could be supported already.

Will it be possible to apply also this one a bit later just because
the patch hunk contexts might be still valid in the (near) future?

Regards,
Markus
