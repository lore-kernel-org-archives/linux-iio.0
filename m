Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:35701 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbbJBI4Y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 2 Oct 2015 04:56:24 -0400
Date: Fri, 2 Oct 2015 11:56:12 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Crt Mori <cmo@melexis.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: iio: mlx90614: Implement filter configuration
Message-ID: <20151002085612.GK7289@mwanda>
References: <20151001221609.GA3694@mwanda>
 <CAKv63usH0CoupUtoAsGjUXUojCJ9sCbK9cN85rz3SS8C0QUWLw@mail.gmail.com>
 <20151002070006.GI7289@mwanda>
 <CAKv63uuxuKJ5QY_jpxVe895+AMhyxWWrCWim6BgeB8kLsoNB-A@mail.gmail.com>
 <20151002083224.GJ7289@mwanda>
 <CAKv63utyg0KwwC0UO+81D2=mQxYVOC0nCjxRB8BNempNEzdx1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKv63utyg0KwwC0UO+81D2=mQxYVOC0nCjxRB8BNempNEzdx1w@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Ok.  Hm...  Then what are the possible positive values of:

	ret = i2c_smbus_read_word_data(client, MLX90614_CONFIG)

regards,
dan carpenter

