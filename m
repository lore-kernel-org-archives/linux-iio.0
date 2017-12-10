Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751994AbdLJTp5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Dec 2017 14:45:57 -0500
Date: Sun, 10 Dec 2017 19:45:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: =?UTF-8?B?aWlvL+KApjo=?= Use common error handling code
Message-ID: <20171210194552.28aa4a9c@archlinux>
In-Reply-To: <f8289b08-389a-a6d6-21f6-ca1ba20c2c85@users.sourceforge.net>
References: <5ab7e200-2dea-63e2-06db-0e185f563d16@users.sourceforge.net>
        <0f26a13b-7bbf-525b-a864-8aa8e13c3aef@users.sourceforge.net>
        <20171026174200.5c00b06d@archlinux>
        <e7292cc3-e4e2-0943-7cf9-4852cf37ef36@users.sourceforge.net>
        <20171210160829.16128419@archlinux>
        <f8289b08-389a-a6d6-21f6-ca1ba20c2c85@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 10 Dec 2017 17:43:34 +0100
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> > Hi Markus, I've accepted the ones that I think made an improvement
> > outweighing the inherent small costs of making any change.  
> 
> Does such a kind of feedback mean that you reconsidered any places
> where you expressed a rejection initially?
No.  Once I have expressed strong reservations about a patch it
would require some change in the facts to make me reevaluate.
> 
> 
> > We also need to avoid code constructs that are unusual in error handling
> > such as backwards gotos.  
> 
> Why would you like to exclude this approach if anything useful could be achieved
> in the shown software design direction?
Yes - exclude this. It trades of ease of review against briefness of code.
Ease of review and hence verification of correctness is more important in these
cases.

> 
> 
> > Note however that most of the changes made so far are only minor improvements.  
> 
> I agree that corresponding effects are small just because the discussed
> source code adjustments affected specific function implementations.
> 
> 
> > I am not saying I don't appreciate them,  
> 
> Thanks.
> 
> 
> > but rather than that they are of of low importance.  
> 
> A lot of details are competing also for our software development attention.
>
Exactly.

Jonathan
 
> Regards,
> Markus

