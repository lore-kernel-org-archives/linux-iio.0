Return-Path: <SRS0=8vNk=SM=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13330C10F11
	for <linux-iio@archiver.kernel.org>; Wed, 10 Apr 2019 15:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF262082E
	for <linux-iio@archiver.kernel.org>; Wed, 10 Apr 2019 15:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554910704;
	bh=g37KnRfc//pFmotHmmLj8k7A+P/LESTGEqR4Om1QUGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nG7SPZRDUj3hwIBOb5z/0DFOHxeevGp3rYh9klKAiYPBpvYw4hv4ioQfM2SfQBHhO
	 WNrUCT0Xm9VGGeq9I4rr3P+w3WSedBf7elEpA+JWN7oo5BX7qD7CRei+20e6AfsNMt
	 iTr89rRqfUfYc0aqBEYgmUgASLrebUnuZ+f+G2Yk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfDJPiY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:38:24 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33649 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731503AbfDJPiY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Apr 2019 11:38:24 -0400
Received: by mail-oi1-f195.google.com with SMTP id e5so2171305oii.0;
        Wed, 10 Apr 2019 08:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RpU8UpLJ5HFoswHUkZjwYAhss7bW1nZkhtWcLu/okjI=;
        b=Qb5vANmymhRfarKgIExfUhMzh/LuWkYRt3FyUBy+tgGAGFgEeyysl0OCAjPy3vw/vL
         D6WHo4TQPhA/juc/W0HGKdVR5TaqrbZhr4B34+/nlKZ3Gve+zSOGsaU3QqtnOUE1rJwD
         ply0lwIoF0iFmQzb7r8GJG4MEpL29ET13Mzb0fIQuvVNSty+6J4HB+fXkHlUou3upcnF
         nu9Vlw9vwUIvt+nv0PUzeHatF36yjYSAkeUrbA4dpO/MgdBlVZIGs5YdkYZMCndq21q2
         /vb1paOqxey9PYaUK65H48qKYQd7FQ0nnalUP5+y4wTUoeFsNaRxumbM0wS3p7UmbBNd
         NQfg==
X-Gm-Message-State: APjAAAXe1ccP9cVuGxwnQnQhPHgU8jyQkDkTUHdmMoiOGIwJyQ29j6p8
        DyPBy99JkiZJFZSJ4R72WhVW3Ps=
X-Google-Smtp-Source: APXvYqyWQEITtQXeh68OTQssIou2ujLaU+oBZ6ji8Vg++Cg0uB4gscy2Cd2rVYHBf6eRpN+dpMA0jw==
X-Received: by 2002:aca:adc8:: with SMTP id w191mr3108320oie.110.1554910703197;
        Wed, 10 Apr 2019 08:38:23 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k60sm15066515otc.42.2019.04.10.08.38.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 08:38:22 -0700 (PDT)
Date:   Wed, 10 Apr 2019 10:38:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsr
 device bindings
Message-ID: <20190410153822.GA31251@bogus>
References: <cover.1554393393.git.lorenzo@kernel.org>
 <d72fe86f431bbf68ebeec0b234f4c57881e86c82.1554393394.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d72fe86f431bbf68ebeec0b234f4c57881e86c82.1554393394.git.lorenzo@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  4 Apr 2019 18:02:35 +0200, Lorenzo Bianconi wrote:
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
