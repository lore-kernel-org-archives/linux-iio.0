Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:46947 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757276Ab3HMTWo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 13 Aug 2013 15:22:44 -0400
Message-ID: <520A877F.6050400@wwwdotorg.org>
Date: Tue, 13 Aug 2013 13:22:39 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
CC: devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com,
	ian.campbell@citrix.com, rob@landley.net, jic23@cam.ac.uk,
	denis.ciocca@st.com, srinivas.pandruvada@linux.intel.com,
	lars@metafoo.de
Subject: Re: [PATCH v3] iio: add Bosch BMA180 acceleration sensor driver
References: <1376408677-25892-1-git-send-email-o.v.kravchenko@globallogic.com>
In-Reply-To: <1376408677-25892-1-git-send-email-o.v.kravchenko@globallogic.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/13/2013 09:44 AM, Oleksandr Kravchenko wrote:
> This patch adds IIO driver for Bosch BMA180 triaxial
> acceleration sensor.
> http://dlnmh9ip6v2uc.cloudfront.net/datasheets/
> 		Sensors/Accelerometers/BST-BMA180-DS000-07_2.pdf

The binding document,
Acked-by: Stephen Warren <swarren@nvidia.com>
