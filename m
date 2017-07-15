Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtprelay0121.hostedemail.com ([216.40.44.121]:45898 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751180AbdGOUiE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Jul 2017 16:38:04 -0400
Message-ID: <1500151079.4457.80.camel@perches.com>
Subject: Re: [PATCH 00/11] Drop unnecessary static
From: Joe Perches <joe@perches.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>,
        linux-arm-kernel@lists.infradead.org
Cc: keescook@chromium.org, kernel-janitors@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Date: Sat, 15 Jul 2017 13:37:59 -0700
In-Reply-To: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 2017-07-15 at 22:07 +0200, Julia Lawall wrote:
> These patches fix cases where there is a static on a local variable, but
> the variable is initialized before any possible use.  Thus, the static has
> no benefit.

Nice one.

