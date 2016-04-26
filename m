Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:44573 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbcDZMB1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Apr 2016 08:01:27 -0400
Subject: Re: [PATCH] iio: tmp006: Set correct iio name
To: Yong Li <sdliyong@gmail.com>
References: <1461296584-11918-1-git-send-email-sdliyong@gmail.com>
 <43150fbd-37ac-2d51-dd87-f41670417b96@kernel.org> <571E854A.90404@gmail.com>
 <7621197a-95ed-239e-8baa-83014bc27a26@kernel.org>
 <571F49B0.4060407@metafoo.de>
 <CADO9-peu32UCxaep8yZUD6XW=ABLGiTYuQJewn-C3Gedc2JewA@mail.gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Crestez Dan Leonard <cdleonard@gmail.com>, knaack.h@gmx.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	=?UTF-8?Q?Krzysztof_Koz=c5=82owski?= <k.kozlowski@samsung.com>,
	mranostay@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <571F588D.3010800@metafoo.de>
Date: Tue, 26 Apr 2016 14:01:17 +0200
MIME-Version: 1.0
In-Reply-To: <CADO9-peu32UCxaep8yZUD6XW=ABLGiTYuQJewn-C3Gedc2JewA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/26/2016 01:47 PM, Yong Li wrote:
> Thanks for your mails. Just FYI, we are testing this tmp006 sensor on
> our system. and our application framework is using these device names,
> so I submitted this patch.

Your patch is certainly correct. But the problem is, or rather the question
is, will this break any existing applications that rely on the wrong behavior?

- Lars
