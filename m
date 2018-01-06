Return-Path: <SRS0=fa8X=EB=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH 1/5] iio: buffer: use permission specific variants of
 DEVICE_ATTR
To: Jonathan Cameron <jic23@kernel.org>, Aishwarya Pant <aishpant@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
 Joe Perches <joe@perches.com>
References: <cover.1515076155.git.aishpant@gmail.com>
 <e6e4f42f8c311533ee29b02ea6207cfbac6a70b0.1515076155.git.aishpant@gmail.com>
 <20180106123521.3bacb64b@archlinux>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <ee271338-ae4a-0c8d-aeaa-0ca2a3ecc3cf@metafoo.de>
Date: Sat, 6 Jan 2018 13:50:28 +0100
MIME-Version: 1.0
In-Reply-To: <20180106123521.3bacb64b@archlinux>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 01/06/2018 01:35 PM, Jonathan Cameron wrote:
> On Thu, 4 Jan 2018 20:07:14 +0530
> Aishwarya Pant <aishpant@gmail.com> wrote:
> 
>> This is a clean-up patch which replaces DEVICE_ATTR macro with the file
>> permission specific DEVICE_ATTR_{RO/WO/RW} macros for compaction and
>> readability. Done using coccinelle.
> 
> Hmm. I'll be honest, I personally really dislike these macros.
> They absolutely don't help with readability because they obscure
> the connection between the attributes being created and their callbacks.
> Short is not the same as more readable.

FWIW fully agreed.
