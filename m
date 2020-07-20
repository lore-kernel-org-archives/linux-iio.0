Return-Path: <SRS0=scSv=A7=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF0AC433E0
	for <linux-iio@archiver.kernel.org>; Mon, 20 Jul 2020 10:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 851A622BF3
	for <linux-iio@archiver.kernel.org>; Mon, 20 Jul 2020 10:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595241406;
	bh=iLZ4SIXh4Bxh8FCnZGnb9g7zaun/2KbgGVui0rGby1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tAxF7n1VDFYD22sQyla5VXaz49KgnQkg1XuH9QyOVVxeWeAWrhxO32zLjQJUt2Jf8
	 8KHVAQwRVaAQuO5/oANCd2ihldOJ9F6iQ6s2C+O7KJ3Uc5Ywf0ikA9vwtn/UC+UILB
	 fPrSecX5Wz0YxUvDLvi8wQrYzvOHDfApiIdyz7kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgGTKgq (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 20 Jul 2020 06:36:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728001AbgGTKgq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Jul 2020 06:36:46 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED44722482;
        Mon, 20 Jul 2020 10:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595241405;
        bh=iLZ4SIXh4Bxh8FCnZGnb9g7zaun/2KbgGVui0rGby1c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jmDdsCsboDzDOfEhpYulRMf5CeDRRTAx+w1+xcsx9Y2JDDfmevidFMgh23pI6i209
         T2jyru/3XEw20r0k79R2pRM8yV5ycUzGiq3fUxX6MULc1R4kLChEVHJJvv7yiUsmRr
         NgJxvDA5sPmQSJa79W0y7CJk6ctdwPBuh+RQ8pZU=
Date:   Mon, 20 Jul 2020 11:36:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Darius Berghe <darius.berghe@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: iio:adc:ltc2371: add support for ltc2361/ltc2363
Message-ID: <20200720113641.171f5134@archlinux>
In-Reply-To: <20200716094611.81746-1-darius.berghe@analog.com>
References: <20200716094611.81746-1-darius.berghe@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 12:46:08 +0300
Darius Berghe <darius.berghe@analog.com> wrote:

> Changelog v1->v2:
> - document power supply in yaml
> - reorder enums in alphabetical order
> - add missing include
> - drop the of_match_ptr protection
> 
> Darius Berghe (3):
>   ltc2471: add of_match_table for existing devices
>   ltc2471: ltc2461/ltc2463 compatible strings
>   ltc2471 driver yaml

All looks fine to me, but please resend with dt list and maintainer
cc'd as patch 3 needs a DT review.

Thanks,

Jonathan

> 
>  .../bindings/iio/adc/adi,ltc2471.yaml         | 49 +++++++++++++++++++
>  drivers/iio/adc/ltc2471.c                     | 25 ++++++++--
>  2 files changed, 70 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2471.yaml
> 

