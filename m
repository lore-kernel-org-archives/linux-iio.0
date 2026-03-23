Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A2E340286
	for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265257; cv=none; b=ACujY8wDeBGff3v3liYKvKSzwYFjdRbEzWUnPPqF/fW8b4uSQCBEuR1Tp1dl5f3PHu5yFuuDQsFBjGdUNyeUrvPlWw8dx9twt3dVX0zQk3bxDGDbnDW2Yi/sVJ9GpWVhc8IFBpjiliDMxi3GiatHi2BIa8hOI+CGk95f6s2mnHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265257; c=relaxed/simple;
	bh=6IqVlaUurZutbzSQdpA0YB19YKETlyEwuy9n8n3mnJo=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type; b=WP0i+P0qTZ8l2KBhQd5B04SvVsdintuh/4dVgtyJmIL0yjZPUw7ZfYzOg7hMtKZVlD5IvOqk8lb8tOfHhsZaAISX5t4ZYbC25DIBqkgg7v3V9d+8semQrZBBQjoJjIBCGFPR3krG1c2r7Dm46DmZtqupxCK1nnfl+5ZL6AUUOwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4ffW902mcyzHnHFD;
	Mon, 23 Mar 2026 19:27:00 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id A86464056B;
	Mon, 23 Mar 2026 19:27:31 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Mar
 2026 11:27:31 +0000
Date: Mon, 23 Mar 2026 11:27:29 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <linux-iio@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>
Subject: IIO: Slightly early likely last date for the 7.1 cycle.
Message-ID: <20260323112729.00003715@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)

Hi All,

As many of you (hopefully) know I tend to have an absolute cut off a few days
before rc7 comes out.  Ideas is that they get some soaking in linux-next
either in my tree, or if I'm cutting it fine for some reason in char-misc.

On this occasion I'm going to be traveling around that time. As such, the
practical last day that I'll merge things for the pull request for 7.1 is
the end of this week with patches pretty much needing to be on list by
Thursday 26 lunch time (GMT).

This only really applies to series undergoing final revisions where we
aren't really expecting additional reviews from others.  Anything else is
now 7.2 material.

I should be back online as normal from around the 11th April.

Thanks,

Jonathan



