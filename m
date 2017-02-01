Return-Path: <SRS0=FEAv=ZO=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH 0/2] iio: pressure: do not rely on structure field
 ordering
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <1485936567-3367-1-git-send-email-peda@axentia.se>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Alison Schofield <amsfield22@gmail.com>,
 Gregor Boirie <gregor.boirie@parrot.com>,
 Sanchayan Maity <maitysanchayan@gmail.com>, Ken Lin <ken.lin@advantech.com>,
 linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <0bee87fa-ee69-c39a-61bb-37960d287889@metafoo.de>
Date: Wed, 1 Feb 2017 09:52:45 +0100
MIME-Version: 1.0
In-Reply-To: <1485936567-3367-1-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 02/01/2017 09:09 AM, Peter Rosin wrote:
> Hi!
> 
> These two patches are needed to fix some fallout from adding the
> available attribute.

I put together a quick cocci script to check for other occurrences of this
issue and these were the only two drivers affected by the issue.
