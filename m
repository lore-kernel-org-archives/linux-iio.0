Return-Path: <SRS0=6njX=RW=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE21C10F03
	for <linux-iio@archiver.kernel.org>; Tue, 19 Mar 2019 08:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0BE20854
	for <linux-iio@archiver.kernel.org>; Tue, 19 Mar 2019 08:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cD3WH8mk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfCSIPC (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:15:02 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42160 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfCSIPB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Mar 2019 04:15:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id v22so10703416lje.9
        for <linux-iio@vger.kernel.org>; Tue, 19 Mar 2019 01:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oZv5rs+2F1G3aw0QW8Edoa29WPzlnhZ8veRi7ouAXDs=;
        b=cD3WH8mkOKvLT3umjGSCOWsEslQ8GTF6SBucBWbCWRK+8NfKZhTEIXFSa2iBExi6Xa
         CmzrNijG0kg8nkhel/S8W3aN5GDYMdvJ1gEL1ffJJq8bq9VYqCmAXhArowO2i+n4Baz6
         FT3TgdHKPDFP6Yt4/Rju8KMNjHflvDoLhs7DuVlhBbbLOxBdFVZF/uw+cqgFKo0C+Ojh
         HmHXIYxuP/XgU1uBDZ3METLq9JV06BIwbEC4Q/lsDuZpffOuWZRpwIfJbilxfGvqKCpC
         W36Nd/jZNtbGjKOpDBvXdwtClR6VlwPclvo8EJNUOPbwf0zg/aHBToe8idHFs1jYgBo4
         QNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oZv5rs+2F1G3aw0QW8Edoa29WPzlnhZ8veRi7ouAXDs=;
        b=uQ0hvYtHGl9r7fJtEWOB/1rUFpKXE0M656bHxY7o1/Q3V8t5+9Zf0/LxYiOUyW/Erl
         Yh6CM4UwPEOeQ7DWH10xcVuQ547Y2Qhn+lA/6OLp2QzBvpH8tvX6vUdrnlDV1RloZsRt
         0w89v6B8vkZcDl5QXIQuCxuJdxuCLAR5pHlTC6d8vbdI/PzP8SQ076rnNQd7lQtbPYwj
         E+q+OxsBtx3SaJR8BPCM5mkLpAUgYkbdrKCMePZpfzy4qn/VQ7dNkP64qI0eRF3WBvk/
         ApO4BjAAv3a126N+fFqcFLJYZKXAf4tyIciTxMAq4qMfN5V6lncTsVFcj3CoL+2xN6Ds
         hobA==
X-Gm-Message-State: APjAAAVdM6vyLaks/YLR4mM5XFl9T63j0OmYjSboSLjrs0tSRiZmeRU+
        cNw/vvYcdFujFo3UfSFA2AQ=
X-Google-Smtp-Source: APXvYqydWcMR1b/G3wV5MHdGwWgrmxKS7h23qKJVqM51x3dfFS+xB86lIpS+jdBRIRg7Yn8KhZxayw==
X-Received: by 2002:a2e:8050:: with SMTP id p16mr4658017ljg.160.1552983299519;
        Tue, 19 Mar 2019 01:14:59 -0700 (PDT)
Received: from ubuntu ([149.126.16.66])
        by smtp.gmail.com with ESMTPSA id o21sm2723111lfl.54.2019.03.19.01.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 01:14:58 -0700 (PDT)
Date:   Tue, 19 Mar 2019 11:14:57 +0300
From:   Vladimir Petrigo <vladimir.petrigo@gmail.com>
To:     Phil Reid <preid@electromag.com.au>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        Renato Lui Geh <renatogeh@gmail.com>,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH 1/3] staging: iio: ad7192: Fix style issue
Message-ID: <20190319081457.GA61719@ubuntu>
References: <1552855992-27653-1-git-send-email-vladimir.petrigo@gmail.com>
 <1552855992-27653-2-git-send-email-vladimir.petrigo@gmail.com>
 <b486e164-7231-728e-6788-c787ed96bb57@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b486e164-7231-728e-6788-c787ed96bb57@electromag.com.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 18, 2019 at 10:27:57AM +0800, Phil Reid wrote:
> On 18/03/2019 4:53 am, Vladimir Petrigo wrote:
> >Signed-off-by: Vladimir Petrigo <vladimir.petrigo@gmail.com>
> >---
> >  drivers/staging/iio/adc/ad7192.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> >index acdbc07..7c632cf 100644
> >--- a/drivers/staging/iio/adc/ad7192.c
> >+++ b/drivers/staging/iio/adc/ad7192.c
> >@@ -355,7 +355,7 @@ ad7192_show_scale_available(struct device *dev,
> >  }
> >  static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
> >-			     in_voltage-voltage_scale_available,
> >+			     in_voltage - voltage_scale_available,
> >  			     0444, ad7192_show_scale_available, NULL, 0);
> >  static IIO_DEVICE_ATTR(in_voltage_scale_available, 0444,
> >
> G'day Vladimir ,
> 
> This is not a mathematical op.
> It gets passed to __ATTR() macro and converted to a string.
> 
> 
> -- 
> Regards
> Phil
Hello Phil,

Thank you for the prompt reply.
Should I remove that changes from the patchset v2 then?

--
Best regards,
Vladimir
