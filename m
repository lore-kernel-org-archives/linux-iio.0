Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx1.emlix.com ([88.198.252.230]:54415 "EHLO mx1.emlix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422AbcDVTgG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 22 Apr 2016 15:36:06 -0400
Received: from mx1.emlix.com (localhost [127.0.0.1])
	by mx1.emlix.com (Postfix) with ESMTP id 99DF323F2CC
	for <linux-iio@vger.kernel.org>; Fri, 22 Apr 2016 21:27:57 +0200 (CEST)
Received: from mailer.emlix.com (unknown [80.150.94.234])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id 8871A23F0E9
	for <linux-iio@vger.kernel.org>; Fri, 22 Apr 2016 21:27:57 +0200 (CEST)
Date: Fri, 22 Apr 2016 21:27:57 +0200
From: Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>
To: linux-iio@vger.kernel.org
Subject: Nonlinear outputs
Message-ID: <20160422192757.GA18225@homes.emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

currently all outputs listed in Documentation/ABI/testing/sysfs-bus-iio
are _raw. What about f.ex. a nonlinear resistive output?

Shall I mark it as processed value which implies giving it an _input name
or shall I fake raw values with offset = 0 and scale = 1?

Best regards,

  Daniel


-- 
Dipl.-Math. Daniel Glöckner, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11,
Bertha-von-Suttner-Straße 9, 37085 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke
Ust-IdNr.: DE 205 198 055

emlix - your embedded linux partner
