Return-Path: <SRS0=wTBL=4Y=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C70C3F2C6
	for <linux-iio@archiver.kernel.org>; Sat,  7 Mar 2020 19:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADAC02073D
	for <linux-iio@archiver.kernel.org>; Sat,  7 Mar 2020 19:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583611012;
	bh=KN3Sv7TPIHL2jajL2yyV2t+KItxKoYgl1XVQ0EKWvoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Tfr6iPWZ/936fXh4bhpGlgeQy+D6C+Ytz7EPzYhp8Rmsi6Nm05d4ac9+dsjEMDGI7
	 Gbv0CptoTNQpx+Mktgs26q6UHuZVK76y8t7SHDdnVsGOufq1G/sA8cmvHKyNv/hhnC
	 tL9Y7g07/fCCHl93gs2sgR/Ju4W2qilhRCgz/9+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgCGT4t (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 7 Mar 2020 14:56:49 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38489 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgCGT4t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Mar 2020 14:56:49 -0500
Received: by mail-pl1-f195.google.com with SMTP id w3so2308344plz.5;
        Sat, 07 Mar 2020 11:56:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZJHn7x3tCKWKvkOIA1jpKoWGEEvmQs0Zz85pOLIDXaI=;
        b=MZ3jKMkpQpKj7P3g6hrPKr+uYuel6SPh+0BI7v1Ic4vLeqWvwXvP3fpmqhUw2LS1Og
         gAPl7IfVn4T2+2Rew9xR8P+BqcPt3msy5K/+vhxDaN/oK7JpSpKL03wP4oLjQ0b3+COh
         YcgXPjJziTWXAHVJ2HjWTMyLJLkbhrCJ0GAoPCJiaw+V15tiL5i55z5eXFcWsz0mYqdz
         DSXpnQbblIemtn4nK1PfB6azKdNyKwD4k5zdTzGYW/8G5Prx5exRQ90X8rZds92jh99o
         4ySHwLOQ07hAM0LWUxzdtG+ShOZw3DGTG504NMVHLzg4uW//PIWUmEbARpJAfEQMR/q1
         z3rg==
X-Gm-Message-State: ANhLgQ2ZUcI5pkO+hg7S5FfKUeumxIcCdtj1aXqJ3uv4TRIaMqofmm/l
        zqZ1tl/7pWGiLdjyWrc/Q3vRKQa2OpY=
X-Google-Smtp-Source: ADFU+vuIIf31eHCggVHKpLnfkn2lIKhPTzyqq8AH8Qby4ah6jhvAqKQyCK3abSV1lbgoavvX3p5LhA==
X-Received: by 2002:a17:90a:2085:: with SMTP id f5mr9930934pjg.101.1583611008164;
        Sat, 07 Mar 2020 11:56:48 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:c2fa:3aa3:193c:db86])
        by smtp.gmail.com with ESMTPSA id u13sm13385246pjn.29.2020.03.07.11.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2020 11:56:47 -0800 (PST)
Date:   Sat, 7 Mar 2020 11:56:46 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v8 1/8] include: fpga: adi-axi-common.h: fixup whitespace
 tab -> space
Message-ID: <20200307195646.GB38707@epycbox.lan>
References: <20200306110100.22092-1-alexandru.ardelean@analog.com>
 <20200306110100.22092-2-alexandru.ardelean@analog.com>
 <20200307142521.3efbe4a4@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307142521.3efbe4a4@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 07, 2020 at 02:25:21PM +0000, Jonathan Cameron wrote:
> On Fri, 6 Mar 2020 13:00:53 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> 
> > The initial version use a tab between '#define' & 'ADI_AXI_REG_VERSION'.
> > This changes it to space. The change is purely cosmetic.
> > 
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Acked-by: Moritz Fischer <mdf@kernel.org>

> Whilst this is trivial it still needs an ack from relevant maintainer
> for that directory. Moritz I think...
> 
> Jonathan
> 
> > ---
> >  include/linux/fpga/adi-axi-common.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/fpga/adi-axi-common.h
> > index 7fc95d5c95bb..ebd4e07ae3d8 100644
> > --- a/include/linux/fpga/adi-axi-common.h
> > +++ b/include/linux/fpga/adi-axi-common.h
> > @@ -11,7 +11,7 @@
> >  #ifndef ADI_AXI_COMMON_H_
> >  #define ADI_AXI_COMMON_H_
> >  
> > -#define	ADI_AXI_REG_VERSION			0x0000
> > +#define ADI_AXI_REG_VERSION			0x0000
> >  
> >  #define ADI_AXI_PCORE_VER(major, minor, patch)	\
> >  	(((major) << 16) | ((minor) << 8) | (patch))
> 
