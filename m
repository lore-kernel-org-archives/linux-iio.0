Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012046.outbound.protection.outlook.com [52.101.126.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B74D3E5A34;
	Fri, 17 Jul 2026 09:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281598; cv=fail; b=tJ25JvZbQzhbdvwuRoYZMxgGEWkou52ao675AzMIYcjOzH7uzzulWq8pVNANMLoD6Zvs3Z+R20JbAttAIFNtDZ2jnuDankXIfZG6m3E8kDQco9ZwfHSOTeC/0+twQ/25B+IE6SohMi0gq5fiIh+w8bRdyfESkFBf7jiHiCBu4Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281598; c=relaxed/simple;
	bh=lCa8Of5sz9kLcx8Xb3jMAHrEoKHZsCQDUk8K2MebVhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VH0TzUYXeYuqQu+LAqjrGAy/Gkobpv+Xqk+gHF+k+Bef6uiaSJVAWbwcEQ2/ifVLImdfdybMbN3A+ao8wHQ50Pcf5s439GxuKBPqRQ6tnHFA3XLXd62f4+VotHjq/6iV0GHsnwS/nqG1yJOBJLBs51vimzuaGi3PjvlHzZk21ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ckmrOxQ2; arc=fail smtp.client-ip=52.101.126.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ckmrOxQ2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vcmnqm52wCi4sLTZalelddLIx0bMDZhOb6SqOJHPP7LeY3+U4cFFKCC+/msSrp9WAYxC+Rg1IQH73NrjFXPQxS5uL7LfN0NZFuHbdzDZ6ZR6gcGLvLTA4ovnCoH4GXtA0bcaYUqSZvYXhJ4b7ER8W8iaDloBO53VMWFwi4uDGI0j7618oqoQKRYc7LKiQYn6lvgSumQ4m5LTP/hDFQ9bkcvynkCJbL6kCBo4h9oIZHE5VYe+x1sfXxVfD0FfwXEDU0x4KdTzs7+l3bt35QyOC/De5fiUM1BOf6dXNb5TiehTEVHreVnw3OJ+nP+AktgzeNqQhXmaq+U/CYIDpvETGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfWF96c2zCrihYJix0d9QRLgmbAeNMrgD5te0mSqFwY=;
 b=CnjZptZKQ5pJgbucJ2nCrSMnYDTI+1wZDV1oKZID9ej6AZ3y2OU3h8iDUJai4N+fySMRWyi9j3LUNCcCSFe08HF2x6dOynf2W4Hnp5dNezCVWRnv8jmgZvjl6GUqv8tqRLn/nAMcxcHkpIhvkwtQz09nHo0QDGa+h32IQM3RT5/ntfueyNj7x7eRrmyLGfyz5wdUQt4gOnmK44FSZRir1DGQOlHisZCzPvm6vNHTW9pxpOhYSUe1beVqZCyEnO6av76WosdaGVtI0I2i+jd+F0Iy2it5YHztk6G+aqR8IWfE6b2kOui+SiNaXT7IG+0Eih06GOkkzOM+Ks8EshW/ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfWF96c2zCrihYJix0d9QRLgmbAeNMrgD5te0mSqFwY=;
 b=ckmrOxQ2Nj80+h97zz0M85pnB8CGtTDaNiD1542chduEPg2LL0mObWGq1IUxj+eAMyNSvUo5cGZ9z08Oloh309eARpHVmGP1ldbNRWc2P1Qup3+GSI4j391udlUuGmHk2oRLa4oBDcE6qO9DxPKEJvYAlR/+22mFNUPQPS5nH12iBbSA8pyssZpvPWFG6qllFP02CDqsD2iYo7JQC33AJGj3iq/9C8+lCCLJ+VoGR6/XSZYPXvt9F273l2rhhLLAqnlOFbt1rfi4wsvPzLrwHFN5/td1VBvXdSWZGB1SBJu6gR4o/GHOXz/JkH5BBsqMUWt1135/jPj7cn+FsLQg7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 09:46:33 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 09:46:33 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-iio@vger.kernel.org (open list:TI HDC302X HUMIDITY DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 07/13] iio: humidity: Remove redundant dev_err()/dev_err_probe()
Date: Fri, 17 Jul 2026 17:42:30 +0800
Message-Id: <20260717094408.509583-8-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717094408.509583-1-panchuang@vivo.com>
References: <20260717094408.509583-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0121.jpnprd01.prod.outlook.com
 (2603:1096:405:379::19) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SI2PR06MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a3a39df-ca06-49fa-c961-08dee3e8494a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|23010399003|11063799006|56012099006|6133799003|22082099003|18002099003|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	ZYe8GkH6cpHMUtvCh6dLu8rjkx0RDLykiqDf0B+Jfoek16cpAcAHz101Xbz6RCscIPBWWphyXqQmOAV2V1HsJs5g861znm5QTiL9R4BgWnJ0HWjgFheHfGBG7WCavUTbMUMngPaM4gAes3E9nNQVsi92TMWVdGoRK/I6Y0tKMukkP/dlk/X0/FXoEIEHF5EmZcoPJzQ30cipk7Ar++EV+jcRW96Zt7TtRZqzNKn2y66KKCv+2vSHmVR0oEFEj82RVwvLbQLIXXel4VcbBc8QCdAdaHGUsde6ylnP7Q+NHmf0MqdJXqYY+SVgB0uvKfTP5xAq6lH71LbfUm1zzrMJdmxcSPuBJ1adImEN2ZZLXJvsuvFVopv+phvZhB88tTQqHNbifhLbRSM+qcHMGjZjMio3pStNjc8zt1TfnV/tQ5DVL/6dLBEiA+Ppn0uG/iETV0h163XzKLyKEr0cVrwX7Jdnlt/4dqkRlhQVJVrS36XDfRK1RnJfgYDuOk2rCTkkcgfvZUP7dSuiAK1EgUTGdVr8cufJa9JFicj40e5cGVUfxOiAqg9xcKltp6hCThmHn8SU/8pwyfrD4zib2ZxZz/RWKGybbY+91b605998/QtroaeAXx/XbO1OOPvToVe5pqdDUVUDgx8bhx7lyIqIy7YjeFQNFUK35ignx/hBVuMEYT30Q4aW2otg/+c0ziiJ3nkeFbuKtsZziuVXejqslLWloWGBmSSSklNicxG9hP8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(23010399003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(10067099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3QTOT2JdI/A9d5sMGS93mLfTaG/eHXEknibsGqFAldefOnWQUDJYAZ5ksnIo?=
 =?us-ascii?Q?HWFBVM98eHTjuAc03heoyDM8umajNG/bJpIue5HaweR0+nmFdwwSi6zCWraw?=
 =?us-ascii?Q?g25pUbhgZVhurmx5zBf17YgN1BB9ES1S7UY4woAmzXDPQbXCJhzPAHKO2P/p?=
 =?us-ascii?Q?kjZHMY2V8F4k9wfI0B2/CuQgGcuI9yBwoWgv45nosrp8Cz12ABtOLREDQXNo?=
 =?us-ascii?Q?5y+FfXellXhY/HWDP/lv7mFCP/bQSLeKd2ljdBQRAorRnc28atQiW/YPjeXz?=
 =?us-ascii?Q?PlBpdDmL4Xfll9kXKsooInxJfYYxVyzUcntSsA0mgpEO/UEcbr10og+NxfK+?=
 =?us-ascii?Q?bZOlMQ7iZe0eAJYBur9YeohLZSK3vcuuHmlHvhuBdzBHNi+ax1O+2JuB/SsI?=
 =?us-ascii?Q?FCOOnrVrR311Zhb5vRVtEXnzwei6fqNlJ9y5UTkx+F1Wvw44cFyUbdK0S88m?=
 =?us-ascii?Q?y5PDhHuohTuto5mpYjh+8YObY9Ejfka3SqdW1RBVeSc9+Oehu4biAwHX99Cd?=
 =?us-ascii?Q?Ao/QI3NSAVMwcrajIYVqB64UHnYSOiSlX4OIX2yaAORgy4t+YTrTYgD9iO+1?=
 =?us-ascii?Q?w+IrSRBo1O2r156gZaxm8wDY17v9kGXlX6z6KU+k35qJBiQPW5IaMzTWZGM2?=
 =?us-ascii?Q?Oph3vVV5Yy2zKCOxghlqUlokz88/OAZJcjtPCwM/s37oi4X/eDOyE07O8QTA?=
 =?us-ascii?Q?DICkFxYvL7sRh0JBJjoHukXXvzCF0AM2qq6QxFBdlKeCTqsCSYyLPFL5KX4H?=
 =?us-ascii?Q?SF87Eb0NJa/z2J8bPKEcPMuxfTU8+zFpw1QDHLcbhH+d06o+a+YDqSxSuj6l?=
 =?us-ascii?Q?H5lS2LOb3114rAyVgiLtHtKQNtOWd3iz+zh6KvaY6h+TboV0YpOjBJmwEIVL?=
 =?us-ascii?Q?w4IdX8Ln5Pky7BaYVnqapxX2Ap2CtBYpdTiQqj4kbL0K7woFdrymDIujOPtk?=
 =?us-ascii?Q?LaOY+J5w/blZBsOeJdBl3zk4PsKrj8dKVcbz+r4tH0kjEmgPc8EHj801/SBV?=
 =?us-ascii?Q?+SCppkqX55BgXGKI1DbGxVpkFvEFdAjB/2PdGPt/3P/lgOpswRb+lxSLalcp?=
 =?us-ascii?Q?F8Ws2323jVcIT44BFshipSL8lCi5ZNIL7tgoMf7r6YY+1TfhzDbvM8oje5gG?=
 =?us-ascii?Q?H3eH7mw8pcyQ6DxXk5tj1BvlsPLJbhJEqoTZk1WEUxLywOsFPuke2Udwd1um?=
 =?us-ascii?Q?4ZV13nDUlyeHawkyygBO1n6aA+NzOPMbRUOcjSoHmIJtOLSDB7Gw3cF4Ce7A?=
 =?us-ascii?Q?raEjAwebiMS/QvO4tDXQracEjtxdOlHd8UfcfHRbDvGFG8v7quUULxpbfCS2?=
 =?us-ascii?Q?ZTRpo7aO4lfe30uNpeFMC71w3CFb9m+sYFaXOHI6Rvel35z7G6zBwGwtLe73?=
 =?us-ascii?Q?lLJ8rysbGExlECYwDATB5Rk2uid3HTMldRXozXeneKe9se5HeE9vhoLYhP18?=
 =?us-ascii?Q?8r6C1jOfi3bBpqfF6NamUX/ppYoy3lrIPnw80on9dGm8192/uJUMNtyrOm8W?=
 =?us-ascii?Q?18OP/Q47E0tN8u63TnaPK7D7CLLHfeExVQ6gpNlmBpvrZBdaCxhSog/fXz8X?=
 =?us-ascii?Q?Nog9hVHG1+iKGnZ6k8m6xQ8b9cDo3URvanSV7e46nlUhyEZrzlq+m7atFmSw?=
 =?us-ascii?Q?h1eY8Eon2IQV0ZaZwXB7a3ThcdFgXPn/EStxWla0h/k5/0653ViJbpPQ+q8I?=
 =?us-ascii?Q?obJv5lmO8ojnsscFp6gKwAeIKxNAeLBvbBf60rd5VZjvTshURkoOPLzjTLsj?=
 =?us-ascii?Q?nhXUOEynHw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3a39df-ca06-49fa-c961-08dee3e8494a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:46:33.6160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZDoaE7MZs9fdJSroWxOfZ6QRUfiFWy8KNGYflsf4PlKppj089ZuuBSCsAzWACZGTAdht0vCZkuKzaFLsWT79g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5139

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() and dev_err_probe() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/iio/humidity/hdc3020.c       | 3 +--
 drivers/iio/humidity/hts221_buffer.c | 5 +----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
index 1ae8702ada54..75971c19624a 100644
--- a/drivers/iio/humidity/hdc3020.c
+++ b/drivers/iio/humidity/hdc3020.c
@@ -843,8 +843,7 @@ static int hdc3020_probe(struct i2c_client *client)
 						IRQF_ONESHOT, "hdc3020",
 						indio_dev);
 		if (ret)
-			return dev_err_probe(&client->dev, ret,
-					     "Failed to request IRQ\n");
+			return ret;
 	}
 
 	ret = devm_iio_device_register(&data->client->dev, indio_dev);
diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
index 4d03db19063e..df12c7a25b2e 100644
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -122,11 +122,8 @@ int hts221_allocate_trigger(struct iio_dev *iio_dev)
 					hts221_trigger_handler_thread,
 					irq_type | IRQF_ONESHOT,
 					hw->name, hw);
-	if (err) {
-		dev_err(hw->dev, "failed to request trigger irq %d\n",
-			hw->irq);
+	if (err)
 		return err;
-	}
 
 	hw->trig = devm_iio_trigger_alloc(hw->dev, "%s-trigger",
 					  iio_dev->name);
-- 
2.34.1

