Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A51CCA47C
	for <linux-iio@archiver.kernel.org>; Thu, 23 Jun 2022 19:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiFWTbe (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiFWTbQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jun 2022 15:31:16 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE8B8894B;
        Thu, 23 Jun 2022 12:02:39 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z7so243820edm.13;
        Thu, 23 Jun 2022 12:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JCErgz0H1oyDXgvoAb85VRrQrpHCFzhnzWBsRkTC1Ro=;
        b=ZYTcLOGJ6iocPPES2rs3DpEF4kmyePCI4155SWosvmdBJCNrlukEDhoLlKtbYz9SDr
         smsBek4ua310ytCYnGatpprCnCZ2zzqErtPMVpGtLhEh1RcqYOAIkMvp7OGLO6DqOMD3
         5298c4Rj/EFO0pxoOJP03nddYnCJ9JnMunmJhmJBvHaWSruOrVwUf0VyQ26nlBEn0Ujr
         su2xN8fm496RtGcO5760doij2gMLpfUpX2Y3oBcVKtQGGGml0tEA6oyEV14y99Mn0TN8
         QmHePZA/iJiageQA7eD1YdsEeYlq/7fKHaCRNFKLTqAi2pnP/ZilymaditFbEt6w+1qI
         O3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JCErgz0H1oyDXgvoAb85VRrQrpHCFzhnzWBsRkTC1Ro=;
        b=UejAMTVUw5BnmAYGPDdoqTHNfc+895KsApkOm3sM6jRYGwsOIM2SDGFYUSt1Nkck2T
         HFZqfGV+URJYr3OajS6JXIFwhYSrfFgxxKCditHTh1fOJviGe/8RMN3MdpBXdW8jLnf7
         dYOr4tPduNRwC7nKF8BZTSgScssyiEWBegVLzEPBVWElV63FW5YyXDjclWf6xjsU0hzp
         iX/asqwctNc7TcF8+jTewBLqrqZPhg2z5eGe+Z422z2FWKVNb7ZXJTXzY+1pJqrLQGn6
         /kLb+ppBhUO3qnzVyOdG1PAr4RDhvfpB2AhIiMvy1yYGH+klSst32cOwwQ73AKfWWju9
         dD5A==
X-Gm-Message-State: AJIora+m6PJSOQ+1OOsNjCV4/Nr0Wp8VwLgq1k7mDyBNvU3N7yLcU5XB
        dB5LTpbJ3rflBMGAdFT0HZII+41K8tdH5lSv07w=
X-Google-Smtp-Source: AGRyM1syrQDkwY335CQS1vBD7K+578crF+8n00y+UpGEUkEUJEF+doQKHrq6xYEeHzvQlnUpp5M8kT8AXNS1vKj8B3U=
X-Received: by 2002:a05:6402:11d2:b0:42d:e68a:eae0 with SMTP id
 j18-20020a05640211d200b0042de68aeae0mr12635838edw.111.1656010957888; Thu, 23
 Jun 2022 12:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220623170844.2189814-1-marcus.folkesson@gmail.com> <20220623170844.2189814-2-marcus.folkesson@gmail.com>
In-Reply-To: <20220623170844.2189814-2-marcus.folkesson@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Jun 2022 21:01:59 +0200
Message-ID: <CAHp75VcYk9PjQ=3ZPB1f=uQ-1GYKnvV-wsu+-z1z81W_ZHCqrw@mail.gmail.com>
Subject: Re: [PATCH 02/10] iio: adc: mcp3911: use resource-managed version of iio_device_register
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 23, 2022 at 7:40 PM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
>
> Keep using managed resources as much as possible.

You may not mix devm_ and non-devm_ API calls like this.
So, you rule of thumb that goto is most of the time wrong after devm_ call.

-- 
With Best Regards,
Andy Shevchenko
