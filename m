Return-Path: <lars@metafoo.de>
Message-ID: <5655B446.5060609@metafoo.de>
Date: Wed, 25 Nov 2015 14:14:46 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Geliang Tang <geliangtang@163.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] iio: fix a problematic usage of WARN_ON()
References: <86c73f180d3054c1bf17bdac8c89026209167c9b.1448456395.git.geliangtang@163.com> <582529c23f77af64373f59fa92e29186df700d79.1448456395.git.geliangtang@163.com>
In-Reply-To: <582529c23f77af64373f59fa92e29186df700d79.1448456395.git.geliangtang@163.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 11/25/2015 02:12 PM, Geliang Tang wrote:
> WARN_ON() takes a condition rather than a format string. This patch
> converted WARN_ON() to WARN() instead.
> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>

Thanks for the patch, the issue was already fixed a few days ago.
