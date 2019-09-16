Return-Path: <SRS0=iV6u=XL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99356C49ED7
	for <linux-iio@archiver.kernel.org>; Mon, 16 Sep 2019 23:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD0D2067D
	for <linux-iio@archiver.kernel.org>; Mon, 16 Sep 2019 23:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDY3f9MM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfIPXuR (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 16 Sep 2019 19:50:17 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:39208 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfIPXuQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2019 19:50:16 -0400
Received: by mail-vs1-f49.google.com with SMTP id f15so850836vsq.6
        for <linux-iio@vger.kernel.org>; Mon, 16 Sep 2019 16:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ma+t2oG96kl8uQ1K++NN4FHTTV388u5fCCeYc9kdVyE=;
        b=iDY3f9MMoZKVTiPvMVk70wNXZWpVb3VjhFp6cJDyIxjtlLHQFPzOfi0qnNDZE3/ako
         1aWK2iNYiq9YbgSBbPaO9x+XJ4bZ0P5BZopLJnHu9m/AFnH7xaLQhd/MX9TSfylJdRxf
         9Vr0n9YdyQOXq/MLAFNeg2ZYYEDnkx1uZCnsl9i27SX7urYwWJ+/bSXNqOkNVZXZvqNB
         e7dsGNGqPLXUIF0WT9vbvTqhRodUzFmjStlpu5O7XywF6WmkooerfA63vy+Tvrgbfw0H
         J3SZHvgvFSso04jq/XSv877G86/HXze2Y5ClenA1WIcCwFu5/WFbICAyp7JEcijHbECu
         /ivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ma+t2oG96kl8uQ1K++NN4FHTTV388u5fCCeYc9kdVyE=;
        b=gI1jLn0jMsXkQPOXDoGQAmO1tY44eJLYXL+4thsn+BoUvWw3T6IFvVcMebf4vGNLfp
         ULRI+l7S5+Y64k3pIJciqmfXBgY56ZbgAKMp7rezyAUO5s2ltxoJd7gMvSubW39k1rYU
         ZSW+dvvRhpD5J+HahAA/HUGpQiVOHBFfQStk+EwRMRsDQjWjuZlPF2V8PQYwtP6JQs5t
         54AVnXDtcGYvVkBgFQEQeEnwwKecLc3vXFBHWhjHbZnqX+5DNhBgo2MKtOwEv/Ff5VqM
         BTt631rmTnCQQVqHAtpoGPoKdIx6wkFhKq+sdOkfTk+zDJO3DmwQ+2QZUWytVohlTy8y
         1QBg==
X-Gm-Message-State: APjAAAXTlrZTxuI/d2x3bDluoD6BeTdAXX+r7cBgd8hyetwtN7sa0hbP
        pVANNxYmboB0qYSAo+XF3ml6HuC1pFxKZ2A9dZkqog==
X-Google-Smtp-Source: APXvYqzqlyny79a006qvOr/pry3xIVebzvnPGkGrp+PX7o8RZvEgoqazUBc2RsiEtChgTLxhbVf2qq+tLhJTqJ61QpY=
X-Received: by 2002:a67:8d08:: with SMTP id p8mr330711vsd.205.1568677815528;
 Mon, 16 Sep 2019 16:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAKxs2cBVnL=6ZNbKgYRppaeUBM3xuog5BHdtmJHRxwttSfjugg@mail.gmail.com>
In-Reply-To: <CAKxs2cBVnL=6ZNbKgYRppaeUBM3xuog5BHdtmJHRxwttSfjugg@mail.gmail.com>
From:   Daniel Junho <djunho@gmail.com>
Date:   Mon, 16 Sep 2019 20:50:04 -0300
Message-ID: <CAKxs2cC1Bqoc6kyz9Cidf_3MHQA-6ZAQJns2pU2CqJ-pMj9ZKA@mail.gmail.com>
Subject: Doubts in getting started with the Analog AD7928 driver
To:     linux-iio@vger.kernel.org
Cc:     lkcamp@lists.libreplanetbr.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello everybody.

I am still learning about kernel developing. I would like to try to
develop a device driver for the AD7928 [1], from Analog Device.

Can someone give some words to guide me?

I was thinking about forking the analog kernel repo [2] but I don't
know to which branch should I commit to when doing a pull request. Or
if this is the correct way for the devices from Analog.

[1] https://www.analog.com/en/products/ad7928.html
[2] https://github.com/analogdevicesinc/linux

Daniel Junho
