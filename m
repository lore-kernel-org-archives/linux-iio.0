Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2011C001B0
	for <linux-iio@archiver.kernel.org>; Tue,  8 Aug 2023 19:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjHHTSi (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 8 Aug 2023 15:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbjHHTRd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Aug 2023 15:17:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B6641218
        for <linux-iio@vger.kernel.org>; Tue,  8 Aug 2023 09:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1691512826; x=1692117626; i=p.jungkamp@gmx.net;
 bh=18wFevJLsDiZsFQVTk1J9k5nBSQD5ODzu19ss65admU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LEWZU+Z827es8IwUCoN3ZNPzQUhUkuJbH2/RMciBDv4hAhvXuNHMiRJJBaIiNPeup3W8i4U
 3Y/ZWs7cJ25bVzp6pVslPd8B62bprzR7pxQUClJ4Z1RkeRRipuk8sOtsFlC4gGD9v9Bk3/Gcf
 vUGm4E1sArZeS0nrCTHG89RKkIREW1OIirpIr97Y/J8MGtXLq4kMupUhFRoSrRzccUQWvYoPR
 9L6jGjymSHgG6CfaaJ/FyhAbZ5WfG3ADnCDq+HclFUONNJAFSQc9qAhPA1r5NKSoJFxRqdvIg
 Ad9lIwynxSfyq9EaegBtw+sRk4CPbrlCes1i6BDsh1ITtEWljO0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [134.130.193.161] ([134.130.193.161]) by web-mail.gmx.net
 (3c-app-gmx-bs40.server.lan [172.19.170.92]) (via HTTP); Tue, 8 Aug 2023
 14:22:10 +0200
MIME-Version: 1.0
Message-ID: <trinity-2e8c2d00-be4a-4590-ae0f-265289d9256b-1691497330952@3c-app-gmx-bs40>
From:   Philipp Jungkamp <p.jungkamp@gmx.net>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Aw: Re: [PATCH] IIO: hid-sensor-prox: add missing scale attribute
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 8 Aug 2023 14:22:10 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <cd33e36768322d4e8f7919711d3474f57c4383ff.camel@linux.intel.com>
References: <20230806130558.89812-2-p.jungkamp@gmx.net>
 <cd33e36768322d4e8f7919711d3474f57c4383ff.camel@linux.intel.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:ED0Ds9WrVVnUXLeCwSaSwEEyITa81AGO3dW3K2wIYMp2VHwmcfJtGVX29NipYFqqxTnq5
 Dk02v3qRJvsXVcxRRn2MHQOm2QkNGYnY5RNpt/Y+s1GsMBVj2uy3qq+qVweuk6DuGJm0ZDmQgRb0
 FfoK/4Y7Jv+ZT6/WqTPTzqp3m9NwpOqd2EnPfcPEqJJ0p5+IAHAsfApDvXQhy6ByQ2LP5STnwbGM
 hDXIIQiiQPyYNzbxiIpKYxsS7FhyHynfAmHYtNZzH3NCEMHW61dNfeH74YNcYBNJdBDkqH0QAjoY
 Wg=
UI-OutboundReport: notjunk:1;M01:P0:DMRA4qhZcuw=;q7f5k2+5/71uFJKu3fYTryU2MCL
 f9K8SvATtma24VKYLkxMA+u5Z8yzyOh/NlafuS5K2RrNQ/ofXhT/UH5P8P1rmRkNcZmSqDVYB
 z5nKXJ0jE2J1AMSZWbssE9NKzGxuSeKI8qyVmBWUTDm4smbz/i16HjDwAV8aTuMsVdbe40K1f
 y2UyIKuEpvuXfyufG6XGfLPlx4sFi8J0Md5Il14Y0rkXbkD6rbE5cD99qqt+qIbSly9SJM7j3
 1UzJYy2mces9VdsWVA1qbzjLxM1GZYhaZH6GLJVKgjO9xGdHJ2EPleuPm1WnXNgiESw6YINfX
 hf0kahQ/Mo71bV8uVRKY5etrvSyNbny8Dmd6edmEdIbBcvtxXnI0azhagHVenbk6dbSE3X4B4
 2ZTmcKshJccNzZIgn+t+VGZllwlfQbvGrHj47tmQN1QDIf9IOIRFiXK8GMPmv1iVsfgqlnIvB
 FCcbn1vfEospD+nbqMPz5ZAKeoqwdT3k/HOAxW4O6GOKwXkYCZfl3qecuBCJTj+S8oPsPt3R/
 h7Ir1yLDGbbBVgayzZKaiibTV3MnMAd+CTiuD2jw14wm22ROC6nDTPqNVz8I08FXq8HRq8Pro
 OuShnaGh9sZAW1rvn4fDYYF7/v/7QdDfqsbmBaY3m8fPpbBUxaPPmWZQrMJxWI0JLIkMQoo9t
 3hV1DxLVTQ47a0DbXEeGSlVdfQC8HtlqLUiDy9lt1MXBRumA7o7PPq2SSyXtKcaJYN5mpMc9H
 lHxdLKdzQh4UNNV9aUXevtUA4MO2NjDp9145Oz9hqLikPDU2OlAGdKK36WKF4tXzN19zSr+83
 zf6n0mF81YgwkVCp1B3Lxo20O7H0svMbajuzWNbnBsPZ8=
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> > The hid-sensor-prox returned an empty string on sysfs
> > in_proximity_scale
> > read. This is due to the the driver's scale never being initialized.
>
> What is scale value reporting here? Is it 1.
>
> Thanks,
> Srinivas

Calling `read` on the sysfs file `in_proximity_scale` returns 0, thus an empty string.
Adding the hid_format_scale call makes that a '1.000000'.

Regards,
Philipp
