Return-Path: <SRS0=p+Fr=RK=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA04C43381
	for <linux-iio@archiver.kernel.org>; Thu,  7 Mar 2019 18:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230EF20851
	for <linux-iio@archiver.kernel.org>; Thu,  7 Mar 2019 18:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BlwaShHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfCGScH (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:32:07 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40681 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfCGScH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Mar 2019 13:32:07 -0500
Received: by mail-pf1-f194.google.com with SMTP id h1so12088596pfo.7
        for <linux-iio@vger.kernel.org>; Thu, 07 Mar 2019 10:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2GV9H2NQZDiYEZ2Q74G2zL9ZSsg7QJ5o+oisANRjH9c=;
        b=BlwaShHM5TSDoUGlDQsOcFHCBRrqkEM93gacCQsJdlo2Z8IHrGiHgGSa4URLLdIl7p
         nZkZNg9A4IOjA9lQ2wwPNIsjAUlfUKSE6kxYhdGFX6bH9NKcIMnn9IPxNZ7HO1ghVXA1
         51eiO3y58HIWGTTrt3gLMvZHo0hLpBcR8oIR+2+SE/60DgRIw2yuPzGWp/+qfqYf5p+l
         yKUmPplHh8FCFCCqk5hKLN2zfmt4CSela6mm07wwgjfZ8PzYEp2S6KRcWxWum+3SVf8g
         0mvlrcfHKY4/9lPolnalVc2H57iwvScO75g7LJ166VMvSOzQqE0G51ElGNh/g1udK6Vc
         W4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2GV9H2NQZDiYEZ2Q74G2zL9ZSsg7QJ5o+oisANRjH9c=;
        b=d/TcDTj55SPDSEsOgCqVQb4dzSCAgwLsOM/XungG5l27ZKdrT+5r1ZNmxlueJXkWoQ
         kVfpWW++h3WdGJj/r8C3dFiORVIEwrSMa2XO6fwukQqvd7/VUaIMdHzY7KO0xltbg6NC
         1GhSA91lpfMPpkhAL7EDbd1CUJ9PR+bW2aIwTaLP+Al6XT9VYZXCoDkqClPWV5/URI6o
         NMlNO2E1vyIBG3j2Jg72Q9qyNiWYjFKkgq6dKjvMDbhGo6C5jjZI3dO8vNOALrkIyL2s
         AjgjUpVjFMLRaVpXSBBNETDPR2UESnn39IkLX8PrC+c9oMjWP/VwOkiuCJjVUQgsL5ZL
         FWSQ==
X-Gm-Message-State: APjAAAVSZcVxwX9RA8x3eWlDfY/HrjFTeqEcZqyFBX40IrUOZiknfWoQ
        E54v7zdmd9gKL1WCiiH1/0jKLUjWdlvNPMuEYaN+oA==
X-Google-Smtp-Source: APXvYqy1GJ+ErVJrILCqHpdsa1dKNd+lAn/tJSdirwDHMCJtq5kHwEBfOCXF+Z/nJG3WtQop4dLwdEMtZuN2/SsdTP8=
X-Received: by 2002:a63:c70c:: with SMTP id n12mr12849683pgg.302.1551983526038;
 Thu, 07 Mar 2019 10:32:06 -0800 (PST)
MIME-Version: 1.0
References: <20190307171604.27791-1-natechancellor@gmail.com>
In-Reply-To: <20190307171604.27791-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Mar 2019 10:31:55 -0800
Message-ID: <CAKwvOdn4s_BdBPtOSyeQfRE+PCQLpDgm9VSkSR6eBkrBp_GhrA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: stmpe-adc: Shuffle an if statement around in stmpe_adc_isr
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Stefan Agner <stefan@agner.ch>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 7, 2019 at 9:16 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with -Wsometimes-uninitialized, Clang warns:
>
> drivers/iio/adc/stmpe-adc.c:204:13: warning: variable 'data' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>
> Clang can't tell that data will never be used uninitialized because the
> two if statements take care of all cases. Remove the first if statement
> and make it the else branch of the second one so that it is apparent to
> Clang that all cases are covered.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/387
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

LGTM, thanks Nathan.
Reviewed-by: NIck Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/iio/adc/stmpe-adc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
> index 37f4b74a5d32..7921f827c6ec 100644
> --- a/drivers/iio/adc/stmpe-adc.c
> +++ b/drivers/iio/adc/stmpe-adc.c
> @@ -184,9 +184,6 @@ static irqreturn_t stmpe_adc_isr(int irq, void *dev_id)
>         struct stmpe_adc *info = (struct stmpe_adc *)dev_id;
>         u16 data;
>
> -       if (info->channel > STMPE_TEMP_CHANNEL)
> -               return IRQ_NONE;
> -
>         if (info->channel <= STMPE_ADC_LAST_NR) {
>                 int int_sta;
>
> @@ -205,6 +202,8 @@ static irqreturn_t stmpe_adc_isr(int irq, void *dev_id)
>                 /* Read value */
>                 stmpe_block_read(info->stmpe, STMPE_REG_TEMP_DATA, 2,
>                                 (u8 *) &data);
> +       } else {
> +               return IRQ_NONE;
>         }
>
>         info->value = (u32) be16_to_cpu(data);
> --
> 2.21.0
>


-- 
Thanks,
~Nick Desaulniers
