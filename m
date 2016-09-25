Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36849 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965935AbcIYQvW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Sep 2016 12:51:22 -0400
Subject: Re: iio: Adjust checks for null pointers in six functions
To: SF Markus Elfring <elfring@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <c11fbb47-1fd3-4e9e-042e-0f271cfef814@users.sourceforge.net>
 <8e0c9fdd-fc9a-0093-278f-00f3beb2a8f6@users.sourceforge.net>
 <5064024e-3510-cec9-d925-b617f7204579@kernel.org>
 <4e79ad49-17fc-1ab9-6a88-06cff959b6de@users.sourceforge.net>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e107c883-eff6-2002-46ba-05e691e142d1@kernel.org>
Date: Sun, 25 Sep 2016 17:51:19 +0100
MIME-Version: 1.0
In-Reply-To: <4e79ad49-17fc-1ab9-6a88-06cff959b6de@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/09/16 15:44, SF Markus Elfring wrote:
>> This is a more worthwhile change in my mind to the jump label changes.
> 
> Thanks for another bit of positive feedback for this refactoring.
> 
> 
>> Would you mind resending with it not based on top of those?
> 
> Is a resend really needed?
It's a question of time.  Maintainers regularly push back stuff
they could fix up themselves purely to save their time.

Also, I'm afraid I don't care enough to put the time in for this
one.  I care enough to review / apply the patch though.
> 
> Does the tool "Git" let you also apply this update step before
> the other suggestions?
It rarely copes with this sort of reordering as it doesn't have
the semantic knowledge of what matters in the other patches.
> 
> Would you dare a reordering of items according to your change preferences?
> 
> Regards,
> Markus
> 

