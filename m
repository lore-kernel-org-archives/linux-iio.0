Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087E535A93B;
	Tue,  5 May 2026 12:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984231; cv=none; b=smyUMk9MLLoOcji+2KxBX9d7yBJIONr4kojRuBzzymA5r7zVtnS1PGHPKkvwZLylaaiXwL/dzK/Kck+U8pZiDwgRlE2zpqtgO8U0xP+IFc1hGmLB65u4Lvb0TrFYeStYP9gChI69TLSHQSUIHl1CAwwzhLxAf40t6P0CD9k2sRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984231; c=relaxed/simple;
	bh=ScsPOoQ8XtoOoDsDDh5tMeKA7mtDLd5bWCoPkW9kqcI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bhgww9flUSpT7nKtHkldS3RGiHjRewJEJXx7oYSxGS/N227uAPKFhdRbpRNMHapO9H088V3dcVfo02u40alDYbj08BLSsGqVgII58duXkGWpkPZGNt2wmjrnuOp3F5VCmlyX5SHmqPf0JtVxBEmbAkIPg/6I/l3FKs4zVCxrQhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uq6gQiZQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uq6gQiZQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7C5C2BCB4;
	Tue,  5 May 2026 12:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777984230;
	bh=ScsPOoQ8XtoOoDsDDh5tMeKA7mtDLd5bWCoPkW9kqcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Uq6gQiZQemsYheWabFar2NMSVsGCSzQM/mUtQbPGv3rJIW6n4sdgm+pGkM3/z8KSp
	 I+s7sK+FAAyRgbClkE4AHuT7hNGWiRyI4S6NGIKsoZFtrA7R0NTBvJfFypN9dILhT+
	 /C8ABYEWHxmuSxQuE1KkkmdtpwdBMDuRUh4f3vK7CvEcUJohRdUGrnmMYY5UpbfuUv
	 /xrmbP39hEwzCiS3Shd0GwRzfIu7D40fHtqfaSQc+wVuuX9FlMtBeeCKUmhVHc9Kk8
	 ohKzAvaAb3Q7xBeA0plljWtAx0X93ygc/uL0N7/JYACYkBo/hwsNUGK621wMPr5Us3
	 2GTHBgnqVEMAQ==
Date: Tue, 5 May 2026 13:30:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jean-Francois Dagenais <jeff.dagenais@gmail.com>, Maxime =?UTF-8?B?Um91?=
 =?UTF-8?B?c3Npbi1Cw6lsYW5nZXI=?= <maxime.roussinbelanger@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 7/8] iio: light: si1133: add local variable for
 timeout
Message-ID: <20260505133022.1e7a0f71@jic23-huawei>
In-Reply-To: <20260505-si1133-checkup-v5-7-5df86a9024ed@gmail.com>
References: <20260505-si1133-checkup-v5-0-5df86a9024ed@gmail.com>
	<20260505-si1133-checkup-v5-7-5df86a9024ed@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 05 May 2026 09:31:32 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> Add local variable for timeout to improve readability.
> 
> No functional change.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Tweaked as I mentioned in my late reply to v4 thread.

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index a3e4ab25acdc..ef5c38e303a6 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -390,7 +390,7 @@ static int si1133_cmd_reset_counter(struct si1133_data *data)
 
 static int si1133_command(struct si1133_data *data, u8 cmd)
 {
-       unsigned long timeout = msecs_to_jiffies(SI1133_COMPLETION_TIMEOUT_MS);
+       unsigned long timeout;
        struct device *dev = &data->client->dev;
        u32 resp;
        int err;
@@ -418,6 +418,7 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 
        if (cmd == SI1133_CMD_FORCE) {
                /* wait for irq */
+               timeout = msecs_to_jiffies(SI1133_COMPLETION_TIMEOUT_MS);
                if (!wait_for_completion_timeout(&data->completion, timeout)) {
                        regmap_write(data->regmap, SI1133_REG_IRQ_ENABLE, 0);
                        err = -ETIMEDOUT;


> ---
>  drivers/iio/light/si1133.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
> index fdffdee16e493277d95c369ec2f6c0678cf9f61c..a3e4ab25acdc105d3800994f4391a7e4291e1c74 100644
> --- a/drivers/iio/light/si1133.c
> +++ b/drivers/iio/light/si1133.c
> @@ -390,6 +390,7 @@ static int si1133_cmd_reset_counter(struct si1133_data *data)
>  
>  static int si1133_command(struct si1133_data *data, u8 cmd)
>  {
> +	unsigned long timeout = msecs_to_jiffies(SI1133_COMPLETION_TIMEOUT_MS);
>  	struct device *dev = &data->client->dev;
>  	u32 resp;
>  	int err;
> @@ -417,8 +418,7 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
>  
>  	if (cmd == SI1133_CMD_FORCE) {
>  		/* wait for irq */
> -		if (!wait_for_completion_timeout(&data->completion,
> -			msecs_to_jiffies(SI1133_COMPLETION_TIMEOUT_MS))) {
> +		if (!wait_for_completion_timeout(&data->completion, timeout)) {
>  			regmap_write(data->regmap, SI1133_REG_IRQ_ENABLE, 0);
>  			err = -ETIMEDOUT;
>  			goto out;
> 

