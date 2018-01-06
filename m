Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753145AbeAFOR4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jan 2018 09:17:56 -0500
Date: Sat, 6 Jan 2018 14:17:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Aishwarya Pant <aishpant@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/5] iio: buffer: use permission specific variants of
 DEVICE_ATTR
Message-ID: <20180106141752.7d4e5c93@archlinux>
In-Reply-To: <alpine.DEB.2.20.1801061418020.2579@hadrien>
References: <cover.1515076155.git.aishpant@gmail.com>
        <e6e4f42f8c311533ee29b02ea6207cfbac6a70b0.1515076155.git.aishpant@gmail.com>
        <20180106123521.3bacb64b@archlinux>
        <ee271338-ae4a-0c8d-aeaa-0ca2a3ecc3cf@metafoo.de>
        <alpine.DEB.2.20.1801061418020.2579@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 6 Jan 2018 14:18:58 +0100 (CET)
Julia Lawall <julia.lawall@lip6.fr> wrote:

> On Sat, 6 Jan 2018, Lars-Peter Clausen wrote:
> 
> > On 01/06/2018 01:35 PM, Jonathan Cameron wrote:  
> > > On Thu, 4 Jan 2018 20:07:14 +0530
> > > Aishwarya Pant <aishpant@gmail.com> wrote:
> > >  
> > >> This is a clean-up patch which replaces DEVICE_ATTR macro with the file
> > >> permission specific DEVICE_ATTR_{RO/WO/RW} macros for compaction and
> > >> readability. Done using coccinelle.  
> > >
> > > Hmm. I'll be honest, I personally really dislike these macros.
> > > They absolutely don't help with readability because they obscure
> > > the connection between the attributes being created and their callbacks.
> > > Short is not the same as more readable.  
> >
> > FWIW fully agreed.  
> 
> Could there be variants that keep the function names as arguments, but
> keep the benefit of the simpler permission specification and ensuring that
> the right functions are provided for the given permissions?

Yes, that would bring the benefits without the readability cost.
No one needs to know that RW means some octal number after all.

Jonathan
> 
> julia
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

