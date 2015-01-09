Return-Path: <lars@metafoo.de>
Message-ID: <54AFF6C4.9020306@metafoo.de>
Date: Fri, 09 Jan 2015 16:41:56 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: Simplify IIO provider access locking mechanism
References: <1420817893-5858-1-git-send-email-iivanov@mm-sol.com>
In-Reply-To: <1420817893-5858-1-git-send-email-iivanov@mm-sol.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 01/09/2015 04:38 PM, Ivan T. Ivanov wrote:
> Instead of checking whether provider module is still
> loaded on every access to device just lock module to
> memory when client get reference to provider device.
>

This has nothing to do with the module, it's about the device. In the Linux 
device driver model as device can be unbound at any time and the IIO 
framework needs to handle this.

- Lars
