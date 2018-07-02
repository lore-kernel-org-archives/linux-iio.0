Return-Path: <SRS0=uL+L=JS=prevas.dk=Sean.Nyekjaer@kernel.org>
Subject: Re: [PATCH] iio: dac: remove redundant variable 'shift'
To: Colin King <colin.king@canonical.com>, Jonathan Cameron
 <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180702102435.16724-1-colin.king@canonical.com>
From: =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean.nyekjaer@prevas.dk>
Message-ID: <62141c55-575a-d068-360a-e0ea53df6f17@prevas.dk>
Date: Mon, 2 Jul 2018 12:43:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180702102435.16724-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 2018-07-02 12:24, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable shift is being assigned but is never used hence it is
> redundant and can be removed.
> 
> Cleans up two clang warnings:
> warning: variable ‘shift’ set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>

Good catch :-)

BR
/Sean
