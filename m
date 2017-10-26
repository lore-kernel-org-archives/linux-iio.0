Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932127AbdJZQo2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 26 Oct 2017 12:44:28 -0400
Date: Thu, 26 Oct 2017 17:44:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-iio@vger.kernel.org,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: iio/pressure/hp206c: Use common error handling code in
 hp206c_conv_and_read()
Message-ID: <20171026174423.210579a6@archlinux>
In-Reply-To: <93642327-2a41-95ca-dd15-3d040fafe845@users.sourceforge.net>
References: <bbe04556-c62c-6074-d663-884a702614f4@users.sourceforge.net>
        <20171026172345.5a88cd73@archlinux>
        <93642327-2a41-95ca-dd15-3d040fafe845@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 26 Oct 2017 18:38:14 +0200
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> > The advantages of this are very limited.  
> 
> Would anybody like to check corresponding effects in more detail?
No readabilty is reduced.  It is a very rare patch that is accepted
where that is the case and the reasons have to be extremely clear
and justified.
> 
> 
> > Hence I am not going to apply it.  
> 
> This is a pity that you like such a kind of source code adjustment
> not so much so far.
> 


