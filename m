Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:36827 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbbJBJF2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 2 Oct 2015 05:05:28 -0400
Received: by laclj5 with SMTP id lj5so88974596lac.3
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2015 02:05:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20151002085612.GK7289@mwanda>
References: <20151001221609.GA3694@mwanda> <CAKv63usH0CoupUtoAsGjUXUojCJ9sCbK9cN85rz3SS8C0QUWLw@mail.gmail.com>
 <20151002070006.GI7289@mwanda> <CAKv63uuxuKJ5QY_jpxVe895+AMhyxWWrCWim6BgeB8kLsoNB-A@mail.gmail.com>
 <20151002083224.GJ7289@mwanda> <CAKv63utyg0KwwC0UO+81D2=mQxYVOC0nCjxRB8BNempNEzdx1w@mail.gmail.com>
 <20151002085612.GK7289@mwanda>
From: Crt Mori <cmo@melexis.com>
Date: Fri, 2 Oct 2015 11:04:47 +0200
Message-ID: <CAKv63uvj_UXxL31eXMTPw6ahs0YEWNkdDnXrHY3e5FN-TxZa4Q@mail.gmail.com>
Subject: Re: iio: mlx90614: Implement filter configuration
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2 October 2015 at 10:56, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Ok.  Hm...  Then what are the possible positive values of:
>
>         ret = i2c_smbus_read_word_data(client, MLX90614_CONFIG)
>

16 bit Config register value, which has some bits fixed to maintain
calibration (14...11;7;3).

> regards,
> dan carpenter
>
