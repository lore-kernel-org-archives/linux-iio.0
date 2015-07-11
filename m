Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48812 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbbGKR2c (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jul 2015 13:28:32 -0400
Message-ID: <55A1523E.7060301@kernel.org>
Date: Sat, 11 Jul 2015 18:28:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Ana Calinov <ana.calinov@gmail.com>, lars@metafoo.de,
	michael.hennerich@analog.com, knaack.h@gm.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: frequency: adf4350: Delete blank line
References: <20150708140431.GA20967@spook>
In-Reply-To: <20150708140431.GA20967@spook>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/07/15 15:04, Ana Calinov wrote:
> This patch removes an unnecessary blank line
> found by checkpatch.pl --strict:
> Blank lines aren't necessary after an open brace '{'.
> 
> Signed-off-by: Ana Calinov <ana.calinov@gmail.com>
Applied to the togreg branch of iio.git. Initially pushed
out as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/frequency/adf4350.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
> index 10a0dfc..9890c81 100644
> --- a/drivers/iio/frequency/adf4350.c
> +++ b/drivers/iio/frequency/adf4350.c
> @@ -72,7 +72,6 @@ static int adf4350_sync_config(struct adf4350_state *st)
>  	for (i = ADF4350_REG5; i >= ADF4350_REG0; i--) {
>  		if ((st->regs_hw[i] != st->regs[i]) ||
>  			((i == ADF4350_REG0) && doublebuf)) {
> -
>  			switch (i) {
>  			case ADF4350_REG1:
>  			case ADF4350_REG4:
> 

