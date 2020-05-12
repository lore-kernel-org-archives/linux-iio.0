Return-Path: <SRS0=x5dW=62=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAFBC54E4A
	for <linux-iio@archiver.kernel.org>; Tue, 12 May 2020 14:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEC9620730
	for <linux-iio@archiver.kernel.org>; Tue, 12 May 2020 14:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589294752;
	bh=DoH/X5aDtvSMxDWJGqC48xOlxwJOdg4XriiP8/OQL7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R8r0nVmDgElmXf+2xB4aTI/EDXxMs8t/Y/A8wNtFCa+Sp96JvruNSGheHafCSzdK3
	 naZNslYgua2UM5AgrRQ0jDyqGvV1rbsUay1kTfJ9vZCZoFqLc30+s1lkK8sKu34JYF
	 Rf4BMFZLs6b+lMkEm4f1lcTVAxB5i/Mm9RIWoQ3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgELOpt (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 12 May 2020 10:45:49 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46815 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgELOpt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 May 2020 10:45:49 -0400
Received: by mail-ot1-f68.google.com with SMTP id z25so10651878otq.13;
        Tue, 12 May 2020 07:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XYysbw64UkCclCYgM2OGMnJLATIny63RyaD7MCp3KWY=;
        b=QJYGF8tW9ZukY2gkx2g2/RVwvADh1GrD8UlVhHy9LUc7fsbWpnNK0ihQX6k7bg+PuO
         174b3w3NGSByrKgL3Fo2/e4TbTsn3TpZ93BduCVqIgQNbsE8ixyh0zsrwsUjDr8Waao+
         qFobxbwQcJ0HH/YHBSG0XgRL9XxicntETEkbl64ipopQKoarYwOteQcLPk87QrzJOmE4
         rSQCLvbG8H1pb9Evuu7Vj0lxG6q8nJCFpPiMfLrfnKTDAoJmgRx+hssLP4wlhLBaeMEg
         cYcfyk35eOq10G9rjP9HJkQmoAdpA1irgdoW3L49Uj3QuIur9zRIbXhJyQnrheV4RGlD
         tUcg==
X-Gm-Message-State: AGi0PuZQ+4IM7chEewjs9C14+GmwAWJjCA6aXIUx7pEN90MplfjYb5+C
        ekqYLPZFOSHW6UDw2DVXyQ==
X-Google-Smtp-Source: APiQypLRGe0NVHMWRSwEojjjgvnlc6nzTgMEhuo7RsnCK7kq1DAeK9fk+yuKCGhkNMIq7L2fX3NANQ==
X-Received: by 2002:a9d:7a98:: with SMTP id l24mr17726019otn.79.1589294748487;
        Tue, 12 May 2020 07:45:48 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x186sm1026630ooa.4.2020.05.12.07.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 07:45:47 -0700 (PDT)
Received: (nullmailer pid 8681 invoked by uid 1000);
        Tue, 12 May 2020 14:45:46 -0000
Date:   Tue, 12 May 2020 09:45:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Saravanan Sekar <saravanan@linumiz.com>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, jic23@kernel.org,
        broonie@kernel.org, lars@metafoo.de, lgirdwood@gmail.com
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: add document bindings for
 wsen-itds accel sensor
Message-ID: <20200512144546.GA7376@bogus>
References: <20200429133943.18298-1-saravanan@linumiz.com>
 <20200429133943.18298-2-saravanan@linumiz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429133943.18298-2-saravanan@linumiz.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 29 Apr 2020 15:39:40 +0200, Saravanan Sekar wrote:
> Add device tree binding information for wsen-itds accel sensor driver.
> 
> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
> ---
>  .../bindings/iio/accel/we,wsen-itds.yaml      | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/we,wsen-itds.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
