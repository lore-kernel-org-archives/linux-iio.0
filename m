Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F5AC433ED
	for <linux-iio@archiver.kernel.org>; Thu, 13 May 2021 11:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A89613F7
	for <linux-iio@archiver.kernel.org>; Thu, 13 May 2021 11:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbhEML3K (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 13 May 2021 07:29:10 -0400
Received: from mx-out1.startmail.com ([145.131.90.139]:43413 "EHLO
        mx-out1.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbhEML3G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 May 2021 07:29:06 -0400
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 May 2021 07:29:05 EDT
Subject: Re: [PATCH] iio: adc: remove unused private data assigned with
 spi_set_drvdata()
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1620904912;
        bh=2+oqodeV0A9s37nXfo0CvOmaq1WiCLKpYgVolFLYqqI=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type:Content-Transfer-Encoding:From:Subject:To:
         Date:Sender:Content-Type:Content-Transfer-Encoding:
         Content-Disposition:Mime-Version:Reply-To:In-Reply-To:References:
         Message-Id:Autocrypt;
        b=vipGEj4141Jdt/z94N5DypyeiPBkKsMsogk832Q7nSOjwOT4oG7RqQWWH8HeNuQW4
         fGHkTlN8lKyvROh6Aik+zNU3ENBZjVYDPEUUelRRRNrn4tVp49CnI6vIDO1v4BrVGd
         jZSXNrr45v9iVgIvl8FM+tHQEXHrggBhESQnjPYLdOgg/rMhpC3i6zVhsIqnnTOAJv
         gkc9Gu8EBxN/C6r2noLJWP+xfjzUh3cSWbqc4Ig6lq7Wn9VPBG3Ts6Fk6GGxkt3eTi
         kenK0QJmP2nYa/FYFfuxhbEDDjiaJZJAfd3N7ZHpSg1dJodwEwmt7fVLQsZ17jZbu2
         IgVbkWn1M5VDg==
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210513111035.77950-1-aardelean@deviqon.com>
From:   Alexandru Lazar <alazar@startmail.com>
Message-ID: <a31b6d94-24cc-6f01-dc36-90c0001ea396@startmail.com>
Date:   Thu, 13 May 2021 14:21:50 +0300
MIME-Version: 1.0
In-Reply-To: <20210513111035.77950-1-aardelean@deviqon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> Some drivers were copied from drivers that fit the criteria described
> above. In any case, in order to prevent more drivers from being used as
> example (and have spi_set_drvdata() needlessly set), this change removes it
> from the IIO ADC group.

Oh yeah, I'm pretty sure that's how I ended up adding it in the max1241 
code, too. Code monkey presents humble apologies :-).

All the best,
Alex
